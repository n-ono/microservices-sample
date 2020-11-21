# microservices-sample

DDD の課題である [鉄道料金計算](https://github.com/masuda220/jr-pricing) を、学習用のマイクロサービスとして実装した

## システム構成

![システム構成](https://user-images.githubusercontent.com/58995947/99874810-e3af5080-2c2d-11eb-8735-328afbda7976.png)

- price calculation microservice などの箱 1 つ 1 つが docker コンテナ になっている

  - ユーザからアクセスできるのは price calculation microservice のみ

- UI は用意していないので price calculation microservice へのリクエストは curl コマンドを利用する

### 各マイクロサービスの責務

- price calculation microservice

  - 鉄道料金計算サービスのオーケストレータで、`( 運賃 + 特急料金 ) x 人数` をして Actor に提示するトータル料金を計算するマイクロサービス
  - 運賃、特急料金、無料になる人数の算出は他のマイクロサービスに移譲する

- fare calculation microservice

  - 1 人あたりの運賃を計算するマイクロサービス
  - 割引の適用は discount calculation microservice に移譲する

- super express surcharge calculation microservice

  - 1 人あたりの特急料金を計算するマイクロサービス
  - 季節の変動料金の調整は本マイクロサービスの責務範囲に含まれる
  - 割引の適用は discount calculation microservice に移譲する

- discount calculation microservice

  - 運賃と特急料金に割引を適用するマイクロサービス
  - 適用する割引は **往復割引** と **団体割引** の 2 種類

- catalogue microservice

  - 基本運賃、基本特急料金、営業キロを管理するマイクロサービス
  - 実際の値は catalogue-db に insert されている ( catalogue-db のラッパ )

- catalogue-db

  - 目的地や列車区分や座席区分などに応じた基本料金、特急料金、営業キロのデータを保持する DB

### 各マイクロサービスとリポジトリの対応表

| マイクロサービス | リポジトリ URL |
| -- | -- |
| price calculation microservice | https://github.com/n-ono/price |
| fare calculation microservice | https://github.com/n-ono/fare |
| super express surcharge calculation microservice | https://github.com/n-ono/super-express-surcharge |
| discount calculation microservice | https://github.com/n-ono/discount |
| catalogue | https://github.com/n-ono/catalogue |

## 実行方法

1. 本リポジトリを clone する

```
$ git clone https://github.com/n-ono/microservices-sample.git
```

2. ディレクトリを移動する

```
$ cd microservices-sample
```

3. DB への接続情報を記載したファイル ( `.env` ) を作成する

```
POSTGRES_USER=catalogue
POSTGRES_PASSWORD=catalogue
POSTGRES_DB=catalogue
```

値はサンプルであり、適宜変更して良い

4. コンテナを起動する

```
$ docker-compose up -d
```

## curl コマンドサンプル

```
$ curl -v -G -d train-type=hikari -d seat-type=reserved -d destination=himeji -d trip-type=round -d children=1 -d adults=2 -d departure-date=20200904 http://localhost:8080/price_calculation/calculate
```

各クエリパラメータの意味と設定値は以下の通り

| クエリパラメータ | 意味 | 設定値 |
| -- | -- | -- |
| train-type | 利用する列車 ( ひかり or のぞみ ) | hikari / nozomi |
| seat-type | 利用する座席 ( 自由席 or 指定席 ) | free / reserved |
| destination | 目的地 ( 新大阪 or 姫路 ) | shinosaka / himeji |
| trip-type | 旅行の種類 ( 片道 or 往復 ) | one-way / round |
| children | 子供の人数 | 0 以上の整数 |
| adults | 大人の人数 | 0 以上の整数 |
| departure-date | 出発日 | yyyymmdd の形式 |


