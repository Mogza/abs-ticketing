package main

import (
	"fmt"
	"github.com/joho/godotenv"
	"github.com/mogza/abs-ticketing/internal/utils"
)

func main() {
	err := godotenv.Load()
	utils.LogFatal(err, "Error loading .env file")

	fmt.Println("Hello World")
	utils.DeployContract()
}
