# Day 39 – What is CI/CD?

## Task 1: The Problem
Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

1. What can go wrong?
   - Overwrites & conflicts: One developer's changes can overwrite anoother's if ther
     push at the same time.
   - No rollback strategy: Reverting to a previous state is often manual, slow, and risky.
   - Human error/Configuration Drift: A deveoper might forget to change config file,
     use the wrong branch, skip a compilation etc.
   - Production Downtime: Manual pushes often requires server restartsor cause 
     service interruptions.
   - No Audit Trail: If the site breaks at 3:00 AM, it is nearly impossible to tell which of the 5 developers' manual changes caused the crash.

2. What does "it works on my machine" mean and why is it a real problem?
   - Definition: A developer's code works fine on his machine but fails in production 
     or any other machine.
   - It happes because of difference in dependencies, OS versions, libraries, database
     schemas.
   - It leads to wasted debugging time, finger-pointing, and unstable deployments

3. How many times a day can a team safely deploy manually?
   - 1–2 times per day at most.
   * Why limited:
       - Each manual deployment requires checks, downtime windows and human oversight.
       - More frequent deployment increases the chance of mistkes and production
         instability.
---

## Task 2: CI vs CD
Research and write short definitions (2-3 lines each):
1. **Continuous Integration** — what happens, how often, what it catches
   - When a developers pushes code to a version control system like(GitHub) the CI system
     automatiocally:
        - Pulls the latest code
        - Builds the application
        - Runs automated tests
        - Validates code quality
        - Generate artifacts if successful
   - How often:
       - Every time a code is pushed, multiple times a day.
   - What it catches:
       - Compiling errors, logic errors, integration issues, environment drift.
   - Example: Facebook
       - Engineers commit code dozens of times per day. Every commit triggers 
         automated  builds and tests across thousands of servers.

2. **Continuous Delivery** — how it's different from CI, what "delivery" means
   - CI stops at `code works and passes tests`.
   - CD ensures the code packaged, versioned and ready to be deployed to
     production at any time.
   - Delivery gurantees production readiness at anytime, a human or automated trigger 
     can deploy it with a single click or command.
   - Example: Amazon
       - Every service is packaged and tested. Artifacts are stored in registries.
         And deployment can be triggred at any time.

3. **Continuous Deployment** — how it differs from Delivery, when teams use it
   - Delivery needs manual approval or trigger.
   - Deployment doesn't need human intervention, every change that passes the pipeline
     is automatically deployed to the production.
   - When teams use:
       - Teams with strong automated test coverage, monitoring and rollback strategies.
       - Small frequen tupdates.
   - Example: Netflix
       - Code that passes automated tests is automatically deployed to production without 
         human approval. It relies on strong monitoring, canary releases and rollback systems.

---

## Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:
- **Trigger** —
   -  What starts the pipeline. It can a push, pull request, sceduled cron job, 
      manual action.
- **Stage** —
   - A logical grouping of jobs, organizes the pipeline into clear 
     phases(build, test, deploy) for readability and control.
- **Job** — 
   - A unit of work inside a stage. 
   - Breaks down stages into smaller, executable tasks.
   - Each job runs independently, can contain multiple steps.
   - Examples: Cloning code, running tests, building images.
- **Step** — 
   - A single command or action inside a job, smallest execution unit.
   - Examples: npm install, docker build
- **Runner** — 
   - The machine that executes the job, it provides the environment where jobs run.
- **Artifact** — 
   - An output produced by a job, stored for later use.
   - Examples: Docker image, compiled binaries.
   - Allows sharing results between stages(build->test->deploy)

---

## Task 4: Draw a Pipeline
Draw a CI/CD pipeline for this scenario:
> A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.

   ![snapshot](ci-cd.png)

---

## Task 5: Explore in the Wild
1. Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
2. Find their `.github/workflows/` folder
3. Open one workflow YAML file
4. Write in your notes:

`https://github.com/kubernetes/minikube/blob/master/.github/workflows/build.yml`

   - What triggers it?
      - Manual action.
      - Push on branch master, pushed only on specified files.
   - How many jobs does it have?
      - It has 3 jobs.
   - What does it do? (best guess)
      - First job build_minikube: It uses ubuntu 22.04 runner, checkouts the code,
        set-up environemnt.
           - download dependncies, builds binaries and uploads artifact.
      - Second job lint: 
           - checks code for style, formatting, and common errors before it runs.
      - Third job unit_test:
           - Does unit test(verifies the smallest pieces of code behaves as expected)
---
 


