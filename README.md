# Partitioned

> Table-based partitioning for ActiveRecord

**Partitioned** simulates partitions with multiple tables.

```rb
employee = Employee.create(name: 'Keith')
```

This would normally produce the following:

```sql
INSERT INTO employees ('name') values ('Keith');
```

With Partitioned, we see:

```sql
INSERT INTO employees_partitions.p1 ('name') values ('Keith');
```

For more information on how partitioned works, see:

- https://github.com/jobseekerltd/partitioned/blob/v2.1.0/README.md
- https://github.com/fiksu/partitioned/blob/v2.1.0/README.md

## Developer setup

Install:

```sh
# Ruby 2.5+ required
rbenv local 2.6.5
bundle install
```

Running tests:

```sh
cd docker
docker-compose up -d

# wait a bit and then
bundle exec rspec
```

Running tests in older rails versions:

```sh
# Rails 4 isn't compatible with Ruby 2.5+
rbenv local 2.4.10
BUNDLE_GEMFILE=Gemfile-rails4 bundle install
BUNDLE_GEMFILE=Gemfile-rails4 bundle exec rspec
```
