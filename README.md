# === DAILY REPORT SYSTEM PROJECT ===

## SETUP

After `git clone`, run these commands:

```bash
$ bundle install
$ bundle execute rake db:reset
$ bundle execute rake db:migrate
$ bundle execute rake db:test:prepare
$ bundle execute rake db:initadmin
```

## ACCESS THE ADMIN

First off, edit `config/routes.rb`, change this line:

```ruby
ActiveAdmin.routes(self) if (!$ARGV.nil? && $ARGV.find_all { |x| x =~ /migrate|rollback/i}.empty?)
```

to this
```ruby
ActiveAdmin.routes(self)
```

Then run the server:

```bash
$ rails server
```
Now access [http://localhost:3000/](http://localhost:3000/) and use this credential to login:

**Email:** `drsprj@gmail.com`
**Password:** `drsprj1234`