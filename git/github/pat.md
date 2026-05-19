Generate a Personal Access Token (PAT) on Github
------------------------------------------------
**Sources**:
- https://docs.github.com/en/get-started/git-basics/set-up-git
- https://docs.github.com/en/get-started/git-basics/about-remote-repositories#cloning-with-https-urls
- https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
- https://docs.github.com/en/organizations/managing-programmatic-access-to-your-organization/setting-a-personal-access-token-policy-for-your-organization#restricting-access-by-personal-access-tokens
- https://stackoverflow.com/questions/75627868/i-noticed-that-the-scope-has-disappeared-under-github-any-ideas-on-finding-it
- https://github.blog/security/application-security/introducing-fine-grained-personal-access-tokens-for-github/


A. Generate a Personal Access Token (PAT) 

1. Sign in to your account on GitHub.com.
2. . Click your profile photo in the upper-right corner and select Settings.
3.  In the left sidebar, scroll down and click Developer settings.
4. Select Personal access tokens and then click one of the two types: [Classic Token](#classic-token) or [Fine-Grained Token](#fine-grained-token) (see [below](#difference-between-"Classic"-and-"Fine-Grained"-access-tokens)).
5. Click Generate new token in of the two ways  (classic or fine-grained, see below).
6. Give the token a descriptive name (e.g., "Work Laptop") and set an expiration date.
7. Select the repo scope to allow basic Git operations like pull and push.
8. Click Generate token and copy it immediately; you will not be able to see it again

B. **On you local environment:**
1. Enable the Credential Helper - Run this command to tell Git to remember your credentials:
```
git config --global credential.helper store
```
2. Trigger the Prompt and Save - Go to your project repository folder and perform a Git operation (like a push):
    ```
    git push
    ```
3. Enter Your Token:
        - Username: Type your GitHub username.
        - Password: Paste your fine-grained token (do not use your account password).

C. **Alternative**:
You can embed your token directly into the remote URL. This bypasses the credential manager entirely.
1. Run this command inside your project folder:
        ```
        git remote set-url origin https://github.com
        ```
2. Replace these placeholders:
        - YOUR_TOKEN: Paste your fine-grained token here.
        - USERNAME: Your GitHub username (or organization name).
        - REPOSITORY: The exact name of your repository.

* To push in a single line using your token over **HTTPS**, use this structure:

    ```
    git push https:// [username] : [token] @://github.com [username] / [repository_name] .git [branch_name]}
    ```

* **SSH** is completely different. It does not use your personal access token at all. Instead, it uses an SSH key pair generated on your computer.To push in a single line using SSH, use this structure:

    ```
    git push git@github.com: [username] / [repository_name] .git [branch_name]
    ```
    


### Recommended Permissions By type of Tokens
**Sources**:
- https://docs.github.com/en/enterprise-server@3.20/rest/authentication/permissions-required-for-fine-grained-personal-access-tokens?apiVersion=2022-11-28
- https://github.com/orgs/community/discussions/160497
- https://docs.github.com/en/enterprise-server@3.15/rest/authentication/permissions-required-for-fine-grained-personal-access-tokens?apiVersion=2022-11-28
- https://docs.github.com/en/enterprise-server@3.18/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

#### Difference Between "Classic" and "Fine-Grained" access tokens:

*  **For all Repos**: Create one **classic token** with the repo scope. Use it for all your projects.
    - A single classic token works for all of your repositories. When you check the repo box during creation, that token gains access to every repository your account can access.
    - The "repo" checkbox is exclusive to Classic tokens.
* ***For one Repo**: Create a **fine-grained token**. Limit it only to the specific repository it needs. 
    - Selected Repositories: You manually pick exactly which repos the token can touch.
    - Because you are creating a Fine-grained token, your permissions are split into individual categories


####  Classic Token
If you prefer the single "repo" checkbox, go back to the menu: 

1. Click Personal access tokens in the far-left sidebar.
2. Click Tokens (classic).
3. Click Generate new token -> Generate new token (classic).
4. The very first checkbox at the top will be repo. 
You only need to check one main box:
- ✅ repo (Full control of private repositories)
- **Note**: Checking this automatically selects the sub-scopes (repo:status, repo_deployment, public_repo, etc.), which allows you to clone, push, pull, and manage branches.

#### Fine Grained Token
1. Scroll past "Repository security advisories" until you find these two settings: 
2. Contents: Click the dropdown next to it and select Read and Write. (This gives you permission to push, pull, and commit code).
3. Pull requests: Select Read and Write. (This allows you to open PRs for your code contributions). 

Under Repository permissions, set these three to Read and Write:

- ✅ Contents: Required to commit, push, and pull code.
- ✅ Pull requests: Required to open and manage PRs.
- ✅ Metadata: Automatically set to Read-only (required for basic Git operations).
- **Note**: Metadata will automatically toggle to Read-only, which is correct and required for Git to function). 

#### When do you need more?
Leave everything else unchecked unless you specifically need to:
workflow (Classic) / Actions (Fine-grained): If you need to edit GitHub Actions .github/workflows files.
write:packages: If your project publishes Docker images or npm packages to GitHub.
If you are ready to set it up, would you like the terminal commands to permanently save this token on your computer so you do not have to type it again?







Step 2: Use the Token as Your Password
The next time you perform a git push or git pull and are prompted for your password, paste the PAT you just created instead of your account password. 
