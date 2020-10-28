package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

const (
	defaultPort = "8080"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World. Hello Cloud Build!!!!!")
}

func main() {
	http.HandleFunc("/", handler)

	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}
	log.Printf("Server listening on port %s.\n", port)
	http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
}
