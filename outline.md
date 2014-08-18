[Work In Progress]

#How we DevOps Golang at VividCortex

- We believe in moving fast.
- So we specifically pick tools that help us do just that.
- This is the reason we build our platform on Golang.

- Intros
  - Owen Zanzal
  - Baron Schwartz
  - What is VividCortex
    - Database Performance Management
    - Our Agents install on

- How did we decide on Golang?
  - We evaluated many Languages
  - Good deployment story
     - Single binary deployable
     - No run time dependencies
  - Performant
     - Efficient use of CPU & memory
     - Concurrency is build in
   - Fast compilation time
   - Easy to pickup
     - Experienced Go devs are rare

- Golang Continuous Integration Pipeline
  
  - CircleCI for testing
     - Github hooks show failure at GitHub pull request
     - Email is dispatched upon error
  
  - Jenkins for building
     - Package Management
       - We need reproducible builds
       - Go does not come with a package manager (npm, gem, maven)
       - Why we wrote Jd
     - Archive build artifacts in Jenkins
  
  - Deploying to stage or production
    - Deployments are triggered via ChatOps commands
      - Developers push when they are ready
      - New developers learn by seeing
      - Makes deployments fun
    - We follow 12 factor app methods
      - We break our system into many simple services
    - Runit for daemon process management
    - Ansible pushes binaries and parameters to target server
    - Success or error message callback
       - Success gifs
       - Link to Jenkins console output upon error.
 
-  Simple does not mean easy
   - Dependency management not included
   - Simplicity isn't free
   - Target multiple platforms not always easy
     - No cross-compile if you link to C libs





- What Effect Does Golang Have on Our Culture?
- Intros
  - Owen Zanzal
  - Baron Schwartz

- So Why Golang?
  - Easy to learn
  - Simplicity
  - Easy to deploy

- Go's Attributes Have Inspired Us
  
  - Easy to learn
    - We encourage continuous learning.
      - Everyone is encouraged to learn Go.
        - We have frontend devs writing Go.
        - Go is being coming the Ops language of cho.
    - New hires are able to pickup Golang fast.
    - Devs that don't have system programing experience are able to pickup 
    - We care about "Time to First Deploy".
    - ChatOps exposes all of the commands you need to stage and deploy code to production
  - New developers onboard quickly.
  - They learn by see others execute commands.
Golang.
  
  - Simplicity
   - We break our system into many simple services
   - We are very skeptical about adopting new technology.
 
  - Easy To Deployment
   - Single binary to deploy
   - Go fits nicely into12 factor app methods
   - Single binary deployment is a ops dream
   - Resolve all dependencies at build time
   - Ship archives and unzip at deploy time

-  Golang simple does not mean easy
    - Can't cross-compile if you link to C lib
    - Dependency management
      - Why we built JD
    - Simplicity != Easy









- Golang is a perfect fit. 
  - It’s easy to install for local development.
  - It compiles fast.
  - Runs performantly.
  - It’s easy for new employees to pick up and become productive.
- Deploying Go is a operations dream
  - Zero runtime dependencies.
  - Single binary to deploy. 
  - Fits well into 12 factor app method.
- Go has spoiled us a bit and we strive to make everything as easy to deploy as Go is.
  - We target multiple platforms, so it’s not as easy as some use cases where it’s for internal consumption only and assumptions/prerequisites can be satisfied.
  - Go isn’t always perfect. There’s no cross-compile if you link to C libs, there’s some OS-specific stuff we do. There’s no vendoring or package versioning built-in (hence jd).
- To try to make deployments more like Go we...
  - For projects with package managers like PHP and Node we resolve all dependencies at build time.
  - We archive all artifacts of that build in a zip file.
  - We ship that archive to the destination server and uncompress.
  - We look for ways to speed up build times.
- When onboarding new developers we want to reduce the “Time to first deploy”.
- The problem with command line tools
  - They don’t scale well as the team grows.
  - They can be difficult to setup.
  - Bad first experience causes fear of use. 
- ChatOps exposes all of the commands you need to stage and deploy code to production
  - New developers onboard quickly.
  - They learn by see others execute commands.
  - They are easy and fun to use.
