# Static server

Stupid simple webserver for serving static files without extras, based on Go.

- Slim, no dependencies.
- No log files.
- Bind to unprivileged port 8080.
- Low memory footprint.
- Docker images for multiple CPU architectures.
- Directory listing only when no index.html is present.

## Example

```
services:
  staticserver:
    image: ghcr.io/adrianrudnik/staticserver:latest
    restart: always
    volumes:
      - ./your-docroot:/var/www
``` 
