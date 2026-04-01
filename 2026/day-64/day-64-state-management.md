# Day 64 -- Terraform State Management and Remote Backends

## Task 1: Inspect Your Current State
Use your Day 63 config (or create a small config with a VPC and EC2 instance). Apply it and then explore the state:

```bash
terraform show                                    # Full state in human-readable format
terraform state list                              # All resources tracked by Terraform
terraform state show aws_instance.<name>          # Every attribute of the instance
terraform state show aws_vpc.<name>               # Every attribute of the VPC
```

Answer:
1. How many resources does Terraform track?
   * 9 resources
2. What attributes does the state store for an EC2 instance? (hint: way more than what you defined)
   * It stores ec2 instance's details about identifiers, networking, storage, tags, lifecycle.
3. Open `terraform.tfstate` in an editor -- find the `serial` number. What does it represent?
   * `serial` number specifies the number of times state is been modified (after a terraform apply, import, or refresh).

---

## Task 2: Set Up S3 Remote Backend
Storing state locally is dangerous -- one deleted file and you lose everything. Time to move it to S3.

1. First, create the backend infrastructure (do this manually or in a separate Terraform config):
```bash
# Create S3 bucket for state storage
aws s3api create-bucket \
  --bucket terraweek-state-<yourname> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable versioning (so you can recover previous state)
aws s3api put-bucket-versioning \
  --bucket terraweek-state-<yourname> \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraweek-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
```

   ![snapshot](images/2-a.png)

2. Add the backend block to your Terraform config:
```hcl
terraform {
  backend "s3" {
    bucket         = "terraweek-state-<yourname>"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraweeterraweek-import-test-mybucketk-state-lock"
    encrypt        = true
  }
}
```

3. Run:
```bash
terraform init
```
Terraform will ask: "Do you want to copy existing state to the new backend?" -- say yes.

   ![snapshot](images/2-b.png)

4. Verify:
   - Check the S3 bucket -- you should see `dev/terraform.tfstate`

   ![snapshot](images/2-c.png)

   - Your local `terraform.tfstate` should now be empty or gone
      * It is empty.
   - Run `terraform plan` -- iterraweek-import-test-mybuckett should show no changes (state migrated correctly)

   ![snapshot](images/2-d.png)

---

## Task 3: Test State Locking
State locking prevents two people from running `terraform apply` at the same time and corrupting the state.

1. Open **two terminals** in the same project directory
2. In Terminal 1, run:
```bash
terraform apply
```
3. While Terminal 1 is waiting for confirmation, in Terminal 2 run:
```bash
terraform plan
```
4. Terminal 2 should show a **lock error** with a Lock ID

   ![snapshot](images/3-a.png)

**Document:** What is the error message? Why is locking critical for team environments?
   * If more than one person is trying to change the state then it will through error
   `Error acquiring the state lock`.
   * It is critical because if more than one person tries to change the state file,
   then it will get corrupted and the whole infra would just fall.

5. After the test, if you get stuck with a stale lock:
```bash
terraform force-unlock <LOCK_ID>
```

---

## Task 4: Import an Existing Resource
Not everything starts with Terraform. Sometimes resources already exist in AWS and you need to bring them under Terraform management.

1. Manually create an S3 bucket in the AWS console -- name it `terraweek-import-test-<yourname>`
2. Write a `resource "aws_s3_bucket"` block in your config for this bucket (just the bucket name, nothing else)
3. Import it:
```bash
terraform import aws_s3_bucket.imported terraweek-import-test-<yourname>
```

   ![snapshot](images/4-a.png)

4. Run `terraform plan`:
   - If you see "No changes" -- the import was perfect
   - If you see changes -- your config does not match reality. Update your config to match, then plan again until you get "No changes"

   ![snapshot](images/4-b.png)

5. Run `terraform state list` -- the imported bucket should now appear alongside your other resources

   ![snapshot](images/4-c.png)

**Document:** What is the difference between `terraform import` and creating a resource from scratch?
   * `terraform import` - Imports already created resources in aws cloud.
   * `resource` - creating resources using tf config file.

---

## Task 5: State Surgery -- mv and rm
Sometimes you need to rename a resource or remove it from state without destroying it in AWS.

1. **Rename a resource in state:**
```bash
terraform state list                              # Note the current resource names
terraform state mv aws_s3_bucket.imported aws_s3_bucket.logs_bucket
```

   ![snapshot](images/5-a.png)

Update your `.tf` file to match the new name. Run `terraform plan` -- it should show no changes.

   ![snapshot](images/5-b.png)

2. **Remove a resource from state (without destroying it):**
```bash
terraform state rm aws_s3_bucket.logs_bucket
```

   ![snapshot](images/5-c.png)

Run `terraform plan` -- Terraform no longer knows about the bucket, but it still exists in AWS.

   ![snapshot](images/5-d.png)

3. **Re-import it** to bring it back:
```bash
terraform import aws_s3_bucket.logs_bucket terraweek-import-test-<yourname>
```

   ![snapshot](images/5-e.png)

**Document:** When would you use `state mv` in a real project? When would you use `state rm`?
   * `state mv` - When you chnaged name of resource in .tf file and avoid terraform thinking recreate/destroy the resource.
   * You want to change resurce name but keep underlying infrastructure.
   * `state rm` - When you want to remove a resource from terraform's control, so terraform doesn't manage it.

---

## Task 6: Simulate and Fix State Drift
State drift happens when someone changes infrastructure outside of Terraform -- through the AWS console, CLI, or another tool.

1. Apply your full config so everything is in sync
2. Go to the **AWS console** and manually:
   - Change the Name tag of your EC2 instance to `"ManuallyChanged"`
   - Change the instance type if it's stopped (or add a new tag)
3. Run:
```bash
terraform plan
```
You should see a **diff** -- Terraform detects that reality no longer matches the desired state.

   ![snapshot](images/6-a.png) 

4. You have two choices:
   - **Option A:** Run `terraform apply` to force reality back to match your config (reconcile)
   - **Option B:** Update your `.tf` files to match the manual change (accept the drift)

5. Choose Option A -- apply and verify the tags are restored.

6. Run `terraform plan` again -- it should show "No changes." Drift resolved.

   ![snapshot](images/6-b.png)

**Document:** How do teams prevent state drift in production? (hint: restrict console access, use CI/CD for all changes)
   * Teams prevent state drift in production by restricting console/CLI access and ensuring all changes go through CI/CD pipelines with version-controlled configurations.

--- 

- Diagram: local state vs remote state setup

   ![snapshot](images/local_remote.png)

- Steps you followed for `terraform import` and the result
   * Manually created resource `terraform-bucket`
   * Added the `aws_s3_bucket` block in `.tf` config with only bucket name.
   * Import using command : `terraform import aws_s3_bucket.imported terraform-bucket`
   * The result - the bucket was added in the state file, `terraform plan` showed no changes to be made.

- When to use: `state mv`, `state rm`, `import`, `force-unlock`, `refresh`
   * If you changed resource manually then update you .tf and use `state mv`
   * If you don't want terraform to control any resource use `state rm`
   * If you want to add a already existing resource use `import`
   * Unlock a stuck state file after a failed operation `force-unlock`
   * Update state without making changes `refresh`

---

