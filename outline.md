[Work In Progress]

- We believe in moving fast and we specifically pick tools that help us do just that.
- Intros
  - Owen Zanzal
  - Baron Schwartz

- What is The Golang Effect?
  - The Tools we pick shape our company culture
    - C++ culture
    - Java culture
    - Ruby culture

- So Why Golang?
  - Easy to learn
  - Performant
  - Fast to compile
  - Easy to deploy

- These Attributes Have Inspired Us
  - Easy to learn
    - We encourage continuous learning
    - Not easy to hire Golang devs... yet. New hires are able to pickup Golang fast.
    - Devs that don't have system programing experience are able to pickup Golang.

- Two Steps Forward 1 Step Back
  - Golang isn't aways perfect
    - Can't cross-compile if you link to C lib


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
  - Bad first experice causes fear of use. 
- ChatOps exposes all of the commands you need to stage and deploy code to production
  - New developers onboard quickly.
  - They learn by see others execute commands.
  - They are easy and fun to use.
