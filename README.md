## Process

### Setup
1. Create Gemfile + run `bundle`
2. Create migrations: run `rake db:create_migration` and add the syntax you need (e.g. NAME=create_users)
3. Migrate: run `rake db: migrate`
* **REMEMBER** never ever ever change anything in schema.
4. Set up associations in classes (belongs_to / has_many / has_many through:)
5. Create seed data + run `rake db: seed`
6. Check if you've seeded correctly: run `rake c` and check what's the last instance of any of your class 

## Gems
- `faker` - randomly generated seed data fun
- `colorize` - colored text output in your terminal
- `tty-prompt` - nice interface for prompting for user input
- `formatador` - styling output information into a neat table
