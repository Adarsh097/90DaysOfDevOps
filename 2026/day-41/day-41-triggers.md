# Day 41 – Triggers & Matrix Builds

## Task 1: Trigger on Pull Request
1. Create `.github/workflows/pr-check.yml`
2. Trigger it only when a pull request is **opened or updated** against `main`
3. Add a step that prints: `PR check running for branch: <branch name>`
4. Create a new branch, push a commit, and open a PR
5. Watch the workflow run automatically

**Verify:** Does it show up on the PR page? - **YES**

   [pr-check.yml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/main/.github/workflows/pr-check.yml)

   * After creating pull request

   ![snapshot](images/1-a)

   * After updating pull request

   ![snapshot](images/1-b)

---

## Task 2: Scheduled Trigger
1. Add a `schedule:` trigger to any workflow using cron syntax
2. Set it to run every day at midnight UTC (`0 0 * * *`)
3. Write in your notes: What is the cron expression for every Monday at 9 AM?
     > 0 9 * * 1

   [schedule.yml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/main/.github/workflows/schedule.yml)

---

## Task 3: Manual Trigger
1. Create `.github/workflows/manual.yml` with a `workflow_dispatch:` trigger
2. Add an **input** that asks for an `environment` name (staging/production)
3. Print the input value in a step
4. Go to the **Actions** tab → find the workflow → click **Run workflow**

**Verify:** Can you trigger it manually and see your input printed?

   [manual.yml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/main/.github/workflows/manual.yml)

   ![snapshot](images/3.png)

---

## Task 4: Matrix Builds
Create `.github/workflows/matrix.yml` that:
1. Uses a matrix strategy to run the same job across:
   - Python versions: `3.10`, `3.11`, `3.12`
2. Each job installs Python and prints the version
3. Watch all 3 run in parallel

   ![snapshot](images/4-a.png)

Then extend the matrix to also include 2 operating systems — how many total jobs run now?
   * Total jobs run **6**

   ![snapshot](images/4-b.png)

---

## Task 5: Exclude & Fail-Fast
1. In your matrix, **exclude** one specific combination (e.g., Python 3.10 on Windows)
   * After adding exclude for python-3.10 on macos it skipped that job.

   ![snapshot](images/5-a.png)

2. Set `fail-fast: false` — trigger a failure in one job and observe what happens to the rest
   * **fal-fast: false**

      ![snapshot](images/false.png)

   * **fail-fast: true**

      ![snapshot](images/true.png)

3. Write in your notes: What does `fail-fast: true` (the default) do vs `false`?
   * `fail-fast: true`: If one job in matrix fails other remaining jobs are 
      automatically cancelled.
   * `fail-fast: false`: Even if one job fails in matrix other jobs continue
      running until completion.

   [matix yml file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/main/.github/workflows/matrix.yml)
---
