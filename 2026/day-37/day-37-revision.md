# Day 37 – Docker Revision & Cheat Sheet

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [x] Run a container from Docker Hub (interactive + detached)
- [x] List, stop, remove containers and images
- [x] Explain image layers and how caching works
- [x] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [x] Explain CMD vs ENTRYPOINT
- [x] Build and tag a custom image
- [x] Create and use named volumes
- [x] Use bind mounts
- [x] Create custom networks and connect containers
- [x] Write a docker-compose.yml for a multi-container app
- [x] Use environment variables and .env files in Compose
- [x] Write a multi-stage Dockerfile
- [x] Push an image to Docker Hub
- [x] Use healthchecks and depends_on

---

## Quick-Fire Questions
Answer from memory, then verify:
1. What is the difference between an image and a container?
    * An image is a blueprint, a container is an actual running instance of an image.

2. What happens to data inside a container when you remove it?
    * It is gone. As containers are ephemeral by nature.

3. How do two containers on the same custom network communicate?
    * Containers can communicate using built-in DNS name resolution (container name → IP)

4. What does `docker compose down -v` do differently from `docker compose down`?
    * `docker compose down -v` - Removes volume also.
    * `docker compose down` - Only removes containers, volume is still attached.

5. Why are multi-stage builds useful?
    * It reduces the size of image by only copying necessary files for build to run stage.

6. What is the difference between `COPY` and `ADD`?
    * `COPY` - Only copies local files.
    * `ADD` - Also copies from web or any tar.

7. What does `-p 8080:80` mean?
    * `-p 8080:80` means map `hostport:containerport`

8. How do you check how much disk space Docker is using?
    * `docker system df`

---

## Build Your Docker Cheat Sheet
Create `docker-cheatsheet.md` organized by category:
- **Container commands** — run, ps, stop, rm, exec, logs
- **Image commands** — build, pull, push, tag, ls, rm
- **Volume commands** — create, ls, inspect, rm
- **Network commands** — create, ls, inspect, connect
- **Compose commands** — up, down, ps, logs, build
- **Cleanup commands** — prune, system df
- **Dockerfile instructions** — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT

   [Docker Cheat Sheet](docker-cheatsheet.md)

---

## Revisit Weak Spots
ALL done.

---

