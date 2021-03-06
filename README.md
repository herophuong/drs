# === DAILY REPORT SYSTEM PROJECT ===

## SETUP

After `git clone`, run these commands:

```bash
$ bundle install
```

Because of xlsx, we need to comment out ActiveAdmin routes initialization before migrate database. 

Change this line in `config/routes.rb`:
```ruby
ActiveAdmin.routes(self)
```

to 

```ruby
#ActiveAdmin.routes(self)
```

then change it back after these command:

```bash
$ bundle execute rake db:migrate
$ bundle execute rake db:test:prepare
$ bundle execute rake db:populate
```

## ACCESS THE ADMIN

First off, run the server:

```bash
$ rails server
```
Now access [http://localhost:3000/](http://localhost:3000/) and use this credential to login:

**Email:** `drsprj@gmail.com`
**Password:** `drsprj1234`

This email is also currently use as the mail agent for the system.
