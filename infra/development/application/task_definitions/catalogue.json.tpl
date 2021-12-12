[{
    "name": "catalogue",
    "image": "your_image_url",
    "portMappings": [{
        "containerPort": 8080,
        "hostPort": 8080
    }],
    "healthCheck": {
        "command": [
            "CMD-SHELL",
            "curl -f http://localhost:8080/catalogue/health || exit 1"
        ],
        "interval": 15,
        "retries": 3,
        "startPeriod": 60,
        "timeout": 10
    },
    "secrets": [{
            "name": "USERNAME",
            "valueFrom": "${database_username}"
        },
        {
            "name": "PASSWORD",
            "valueFrom": "${database_password}"
        },
        {
            "name": "ENDPOINT",
            "valueFrom": "${database_endpoint}"
        }
    ]
}]