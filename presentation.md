![bg](https://farm8.staticflickr.com/7355/10501320136_09c1f747f5_b.jpg)


# The Golang Effect

How Go shaped <br> operations at VividCortex

!

![bg](https://farm3.staticflickr.com/2512/4410634458_0c490cb327_b.jpg)


## We believe in <br> moving fast.

!

![bg](https://farm9.staticflickr.com/8179/8005616664_1a1b7dd54c_b.jpg)

## We pick tools & processes that help <br> us do just that.

!

![bg](https://dl.dropboxusercontent.com/u/69816878/shipit-with-hubot/vc-team.jpg)

## About Us

@AgentO3

- Developer
- Ops & Automation
- Organizing DevOpsCV
- Brewing beer

!

![bg](https://dl.dropboxusercontent.com/u/69816878/shipit-with-hubot/vc-team.jpg)


## About Us

@xaprb

- Founder CEO
- Author of High Performance MySQL
- CrossFit
- Deep thoughts

!

![bg](https://farm5.staticflickr.com/4106/4833452024_7b8ed6f9c7_b.jpg)

## About VividCortex

- Observe and Measure OS & DB Performance
- Samples at 1 second granularity
- Rank, compare, graph, notifications, fault detection, & much much more

!

![bg](https://farm3.staticflickr.com/2084/2454538469_2399e0b1cb_o.jpg)

## August 30th marked our <br> 2nd Birthday

!

![bg](https://farm4.staticflickr.com/3506/3918407586_b74efc514d_b.jpg)

## What lead us to Golang?

!

![bg](https://farm9.staticflickr.com/8529/8553577728_a2ef963df9_b.jpg)

## We evaluated many languages

!

![bg](https://farm7.staticflickr.com/6039/6248560095_fecca3cc0d_b.jpg)

## A carefully crafted to solve real problems

!

![bg](https://farm8.staticflickr.com/7121/6994968467_6e737f0925_b.jpg)

## Good deployment story

 - Single binary deployable
 - No run time dependencies

!

![bg](https://farm3.staticflickr.com/2482/3863031903_da8d47dbfc_b.jpg)

## Performant

 - Efficient use of CPU & memory
 - Concurrency is built in

!

![bg](https://farm4.staticflickr.com/3127/2800472595_2fdbfd3767_b.jpg)

## Very fast <br> compilation time

!

![bg](https://farm6.staticflickr.com/5278/5852610806_4708435486_b.jpg)

## Easy to pickup

- For now... Go devs are rare
- Familiar... Like C and Python had a baby

!

![bg](https://farm1.staticflickr.com/26/55109059_55408b3d5f_o.jpg)

## Not Always Rainbows

!

![bg](https://farm1.staticflickr.com/26/55109059_55408b3d5f_o.jpg)

## Simple does <br> not mean easy

 - No Generics
 - Some things require a little DIY

!

![bg](https://farm1.staticflickr.com/26/55109059_55408b3d5f_o.jpg)

<div class="code">
sorter := make([]int, 0, len(upgradesToRun))

for i := range upgradesToRun {
	sorter = append(sorter, i)
}

sort.Ints(sorter)

for _, i := range sorter {
	filepath := upgradesToRun[i]
}
</div>

!

![bg](https://farm2.staticflickr.com/1217/1149317580_c2e8991648_b.jpg)

## Dependency management not included

!

![bg](https://farm5.staticflickr.com/4042/4329043622_1a9071691f_b.jpg)

## Target multiple platforms <br> not always easy

- No cross-compile if you link to C libs

!

![bg](https://farm6.staticflickr.com/5550/9294639633_41119647f0_b.jpg)

## The Go CI Pipeline

!

![bg](https://farm8.staticflickr.com/7340/11453238016_7159d45ee2_b.jpg)

## Testing

 - CircleCI automates testing
 - Github hooks show failure at GitHub pull request button
 - Everyone is notified of failure via email

!

![bg](https://farm6.staticflickr.com/5580/14261010472_efa0613571_b.jpg)

## Building

!

![bg](https://farm8.staticflickr.com/7440/11253216745_73dbd89fd7_b.jpg)

## Jenkins automates <br>build process

- Parameterized triggers to chain jobs together
- Describe jobs in the Jenkins job DSL

[example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/job-dsl-golang.groovy)

!

![bg](https://farm1.staticflickr.com/50/160490011_b0cecf8fa1_b.jpg)

## Package Management

 - Go does not come with a package manager (npm, gem, maven)
 - We need reproducible builds
 - Why we wrote jd and it's opensource

[example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/godeps)

!

![bg](https://farm8.staticflickr.com/7029/6498650083_fceb593ee8_b.jpg)

## Archive build <br> artifacts in Jenkins

[example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/api-ping-example.groovy)

!

![bg](https://farm4.staticflickr.com/3129/3239955539_5d3748e3e4_b.jpg)

## Deploying

!

![bg](https://farm4.staticflickr.com/3622/3630287042_a5f82e7579_o.jpg)

### Triggered via ChatOps Commands

- Command line tools don't scale
- Push when you are ready
- New developers learn by seeing
- Makes deployments fun

!

![bg](https://farm4.staticflickr.com/3622/3630287042_a5f82e7579_o.jpg)

![agentdeploy](https://dl.dropboxusercontent.com/u/69816878/agentdeploy.png)

![agentdeploy](https://dl.dropboxusercontent.com/u/69816878/lastagents.png)

[example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/release.coffee)


!

![bg](https://farm8.staticflickr.com/7053/6857684376_1f06319e5e_b.jpg)

## Ansible pushes binaries to target server

- Orchestrates any services restarts

[example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/release-api.groovy)

!

![bg](https://farm3.staticflickr.com/2808/10830400356_1350dd5815_b.jpg)

## Go plays nicely with <br> 12 factor app methods

- We break our system into many simple apps
- Apps get configuration from env vars
- Capture logs from stdout

!

![bg](https://farm4.staticflickr.com/3212/2540855193_136b996426_b.jpg)

## Runit for daemon process management

- Automatically starts & restarts service
- Correctly handles log rotation

!

![bg](https://farm5.staticflickr.com/4129/4982722491_7342befb96_b.jpg)

## Callback to chatroom

 - Success gifs for motivation
 - Link to Jenkins console output upon error

 [example](https://github.com/AgentO3/the-golang-effect/blob/master/examples/hubot-callback.groovy)

!

![bg](https://farm5.staticflickr.com/4129/4982722491_7342befb96_b.jpg)

![success](https://dl.dropboxusercontent.com/u/69816878/success.png)

![cat](http://37.media.tumblr.com/2b9f0de5f8cdd8f3d844dd6803a6ea74/tumblr_n0ed00QgsB1s2mmayo1_400.gif)

!

## Inspiration From Go

![bg](https://farm2.staticflickr.com/1354/591400369_ebe69c515e_b.jpg)

- For non-Go projects we resolve all dependencies at build time
- Emulate Go binary deployable story by archiving build artifacts
- Ship archive to server where we unpack and install

!

![bg](https://farm9.staticflickr.com/8397/8708600748_efee4aea55_b.jpg)

## Go in Operations

!

![bg](https://farm8.staticflickr.com/7176/6873455455_a83756275c_b.jpg)

### Internal Ops Tools Built with Go

- Go Migrate | DB Shard schema migration tool
- BumpIt | Semantic version bumping tool
- Check Health | Polls Consul API and notifies chatroom about failed health checks

!

![bg](https://farm4.staticflickr.com/3449/3913570797_4c67a8e07a_b.jpg)

## In Conclusion

- Think deeply about your tools and processes
- Apply "Kaizen" to your organization
- Use the Job DSL
- Go is our go to language
- Things would be much different without it

!

![bg](https://farm4.staticflickr.com/3449/3913570797_4c67a8e07a_b.jpg)

## Thanks Surge Conf!

@xaprb <br>
@AgentO3

<!-- !

![bg](https://farm4.staticflickr.com/3449/3913570797_4c67a8e07a_b.jpg)

### DevOpsCV Invites You To Charlottesville

- Spend the Day at VividCortex HQ
- Lunch, Dinner, & Beer or Wine
- Make it a long weekend -->
