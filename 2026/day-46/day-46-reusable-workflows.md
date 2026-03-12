# Day 46 – Reusable Workflows & Composite Actions

## Task 1: Understand `workflow_call`
Before writing any code, research and answer in your notes:
1. What is a **reusable workflow**?
  * If multiple workflows share a series of steps. Instead of duplicating workflow code in multiple places, we can create one reusable workflow and have other workflows call it.

2. What is the `workflow_call` trigger?
  * The `workflow_call` event enable one worflow to use another `reusable` `callable`
    workflow. This promotes the reusability of workflows across different repositories or within the same repository.

3. How is calling a reusable workflow different from using a regular action (`uses:`)?
  * Regular action `uses` perform specific tasks like code checkout, set up python.
  * Where as reusable worflow contains entire job, including their own runner, env.

4. Where must a reusable workflow file live?
  * Under `./.github/worflows` folder.

---

## Task 2: Create Your First Reusable Workflow
Create `.github/workflows/reusable-build.yml`:
1. Set the trigger to `workflow_call`
2. Add an `inputs:` section with:
   - `app_name` (string, required)
   - `environment` (string, required, default: `staging`)
3. Add a `secrets:` section with:
   - `docker_token` (required)
4. Create a job that:
   - Checks out the code
   - Prints `Building <app_name> for <environment>`
   - Prints `Docker token is set: true` (never print the actual secret)

**Verify:** This file alone won't run — it needs a caller. That's next.

   [reuable workflow file](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/03d24669ee8a1d7c9b80280e1426c105962a6c32/.github/workflows/reusable-build.yml)

---

## Task 3: Create a Caller Workflow
Create `.github/workflows/call-build.yml`:
1. Trigger on push to `main`
2. Add a job that uses your reusable workflow:
   ```yaml
   jobs:
     build:
       uses: ./.github/workflows/reusable-build.yml
       with:
         app_name: "my-web-app"
         environment: "production"
       secrets:
         docker_token: ${{ secrets.DOCKER_TOKEN }}
   ```
3. Push to `main` and watch it run

**Verify:** In the Actions tab, do you see the caller triggering the reusable workflow? Click into the job — can you see the inputs printed?

   [caller file yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/03d24669ee8a1d7c9b80280e1426c105962a6c32/.github/workflows/call-build.yml)

   ![snapshot](images/3.png)

---

## Task 4: Add Outputs to the Reusable Workflow
Extend `reusable-build.yml`:
1. Add an `outputs:` section that exposes a `build_version` value
2. Inside the job, generate a version string (e.g., `v1.0-<short-sha>`) and set it as output
3. In your caller workflow, add a second job that:
   - Depends on the build job (`needs:`)
   - Reads and prints the `build_version` output

**Verify:** Does the second job print the version from the reusable workflow?

   ![snapshot](images/4.png)

---

## Task 5: Create a Composite Action
Create a **custom composite action** in your repo at `.github/actions/setup-and-greet/action.yml`:
1. Define inputs: `name` and `language` (default: `en`)
2. Add steps that:
   - Print a greeting in the specified language
   - Print the current date and runner OS
   - Set an output called `greeted` with value `true`
3. Use the composite action in a new workflow with `uses: ./.github/actions/setup-and-greet`

**Verify:** Does your custom action run and print the greeting?

   [composite action yml](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/acacc837ce3e544adc33300c7d7d112466b8d1ef/.github/actions/setup-and-greet/action.yml)

   [greet yml using composite action](https://github.com/Afroz-J-Shaikh/github-actions-practice/blob/acacc837ce3e544adc33300c7d7d112466b8d1ef/.github/workflows/greet.yml)

   ![snapshot](images/5.png)

---

## Task 6: Reusable Workflow vs Composite Action
Fill this in your notes:

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` in a step |
| Can contain jobs? | Yes | No |
| Can contain multiple steps? | Yes | Yes |
| Lives where? | ./.github/workflows/ | ./.github/actions/ |
| Can accept secrets directly? | Yes | No |
| Best for | multiple reusable jobs | reusable steps |

---

