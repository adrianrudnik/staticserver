package main

import (
	"log"
	"mime"
	"net/http"
)

const BindPort = ":8080"
const DocumentRoot = "/var/www"

func main() {

	addMime(".apk", "application/vnd.android.package-archive")
	addMime(".json", "application/json")

	fs := http.FileServer(http.Dir(DocumentRoot))

	http.Handle("/", fs)

	log.Printf("Serving %s on %s", DocumentRoot, BindPort)

	err := http.ListenAndServe(BindPort, nil)
	if err != nil {
		log.Fatal(err)
	}
}

func addMime(ext string, typ string) {
	err := mime.AddExtensionType(ext, typ)
	if err != nil {
		log.Fatal(err)
	}
}
