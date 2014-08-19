#The Golang Effect - How Golang shaped operations at VividCortex

- We believe in moving fast.
- So we specifically pick tools that help us do just that.
- This is why we built our platform on Golang.

- Intro
  - Owen Zanzal
    - Developer
    - Automation
    - Brewing beer
  - About VividCortex
    - Funded Startup located in Charlottesville VA
    - Database Performance Management is our nitch
    - Single line bash script to install agents
    - Observes OS metrics, sniffs tcp and parses MySQL protocol
    - Sends back to VC at 1 second granularity 
    - Rank, compare, graph, notifications, fault detection, chop, slice, and dice
    - This month is our 2 year anniversary 

- What lead us to Golang?
  - We evaluated many Languages
  - A carefully crafted Language
  - Good deployment story
     - Single binary deployable
     - No run time dependencies
  - Performant
     - Efficient use of CPU & memory
     - Concurrency is built in
  - Wicked fast compilation time
  - Easy to pickup
     - Experienced Go devs are rare

- Not all Rainbows and Gophers
  - Simple does not mean easy
     - No Generics 
     - Sometimes you need to do things your self
  - Dependency management not included
  - Target multiple platforms not always easy
     - No cross-compile if you link to C libs

- The Go CI Pipeline
  - Testing
     - CircleCI automates testing
     - Github hooks show failure at GitHub pull request
     - Email is dispatched upon error
  
  - Building
     - Jenkins automates build process 
       - ProTip: Jenkins UI sucks! Use the Job DSL
     - Package Management
       - We need reproducible builds
       - Go does not come with a package manager (npm, gem, maven)
       - Why we wrote Jd
     - Archive build artifacts in Jenkins
  
  - Deploying
    - Deployments are triggered via ChatOps commands
      - No gatekeepers
      - Push when you are ready
      - New developers learn by seeing
      - Makes deployments fun
    - Ansible pushes binaries to target server
    - Orchestrates any services restarts 
    - Runit for daemon process management
      - Auto restarts services when they crash
      - Pipes stdout to log
      - Correctly handles log rotation 
    - We follow 12 factor app methods
      - Golang apps fit well into 12 factor
      - We break our system into many simple apps
      - Apps get configuration from env vars
    - Success or error message callback to chatroom
       - Success gifs
       - Link to Jenkins console output upon error

- Golang in Operations
  - Tool of choice for internal tools
    - Go Migrate | DB Shard migration tool
    - BumpIt | Semantic version bumping tool
    - Check Health | Polls Consul API and notifies chatroom about failed health checks
