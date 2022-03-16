# README

### Installation
DB: PostgreSQL

```
bundle
rails db:setup
rails server
```

### Original task:
Imagine we’ve been working with a company who produces a wearable device to measure body temperature
(to predict onset of illness). We need to store that data in the Rails backend. There is also a
device-specific temperature “offset” value which, when summed with the raw reading from the device will
give the actual temperature value. This offset may change over time.

Using Rails + database, please design and build a REST API interface to:

a) set offset

b) store temperature readings for a user

c) list historical data readings. 

The system should send a simple alert if the temperature appears to be trending to exceed 37.5C. 
For the purpose of this exercise, assume that trending means that the last 5 readings are getting closer to the threshold.

Please write appropriate tests with rspec. Document your design decisions to explain your thinking.
For the purposes of this exercise, ignore auth.

### Solution

Rails seed data has successful case and fail scenario `Temperature` sets for 2 different `Users`.
Main focus was on implementing the service object which takes `User` record as an argument and returns boolean
response. Can be checked manually via rails console: 

```
NotificationService.new(User.first).notify_user?
```

```
NotificationService.new(User.last).notify_user?
```

The email alert concept was implemented in `after_action` of `TemperaturesController`. Can be triggered by sending
`POST` request to:

`localhost:3000/users/1/temperatures?value=37` (this way we increment the sequel value which is approaching to 
`ILLNESS_THRESHOLD` defined as `37.5`)

You will get the following output in rails server logs:

```
"user_1@test.test: YOU ARE GOING TO GET SICK!"
```

### Implementation details

The default incrementation step is `0.1` for `Temperature` and `Offset` records. `Offset` is global.

User temperature sequence is considered trending if the set of last 5 records keeps incrementing and the final value from
the set of 5 is greater than or equal to the (`ILLNESS_THRESHOLD` - `PREDICTION_GAP`).

`PREDICTION_GAP` is configurable and it was added for the reason of giving prediction instead of letting users know they
are already sick (makes sense IMO)

The project has specs: 

```
rspec
```

The coding challenge was implemented as per my personal assumption having limited time and the absence of communication.