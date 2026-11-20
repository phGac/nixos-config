#compdef supabase
###-begin-supabase-completions-###
#
# Static completion script for Zsh
#
# Installation:
#   supabase --completions zsh > ~/.zsh/completions/_supabase
#   then add ~/.zsh/completions to your fpath
#

_supabase() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'backups:Manage Supabase physical backups'
    'bootstrap:Bootstrap a Supabase project from a starter template'
    'branches:Manage preview branches'
    'completion:Generate the autocompletion script for the specified shell'
    'config:Manage project configurations'
    'db:Manage databases'
    'domains:Manage custom domain names for Supabase projects'
    'encryption:Manage encryption keys'
    'feedback:Send feedback to the Supabase team'
    'functions:Manage Supabase Edge functions'
    'gen:Run code generation tools'
    'init:Initialize a local project'
    'inspect:Inspect project tools'
    'issue:Open GitHub issue forms'
    'link:Link to a Supabase project'
    'login:Authenticate using an access token'
    'logout:Log out and delete access tokens locally'
    'logs:Browse local or hosted logs. Arrows select, Enter details, C copies, L loads more logs, and q quits. Custom SQL uses L to rerun. Pipes and machine output read once. Explicit --output-format text disables the viewer. Use --output-format json|stream-json for structured output; -o/--output is unsupported.'
    'migration:Manage database migration scripts'
    'migrations:Manage database migration scripts'
    'network-bans:Manage network bans'
    'network-restrictions:Manage network restrictions'
    'notebooks:Manage Supabase notebooks'
    'orgs:Manage Supabase organizations'
    'postgres-config:Manage Postgres database config'
    'projects:Manage projects'
    'pull:Pull remote project state into the local checkout'
    'secrets:Manage Supabase secrets'
    'seed:Seed a Supabase project'
    'services:Show versions of all Supabase services'
    'snippets:Manage Supabase SQL snippets'
    'ssl-enforcement:Manage SSL enforcement'
    'sso:Manage Single Sign-On (SSO) authentication'
    'start:Start local Supabase stack'
    'status:Show status of local Supabase containers'
    'stop:Stop all local Supabase containers'
    'storage:Manage Supabase Storage objects'
    'telemetry:Manage telemetry'
    'test:Run tests on local Supabase containers'
    'unlink:Unlink a Supabase project'
    'vanity-subdomains:Manage vanity subdomains'
    'whoami:Show the current user'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        backups)
          _supabase_backups
          ;;
        bootstrap)
          _supabase_bootstrap
          ;;
        branches)
          _supabase_branches
          ;;
        completion)
          _supabase_completion
          ;;
        config)
          _supabase_config
          ;;
        db)
          _supabase_db
          ;;
        domains)
          _supabase_domains
          ;;
        encryption)
          _supabase_encryption
          ;;
        feedback)
          _supabase_feedback
          ;;
        functions)
          _supabase_functions
          ;;
        gen)
          _supabase_gen
          ;;
        init)
          _supabase_init
          ;;
        inspect)
          _supabase_inspect
          ;;
        issue)
          _supabase_issue
          ;;
        link)
          _supabase_link
          ;;
        login)
          _supabase_login
          ;;
        logout)
          _supabase_logout
          ;;
        logs)
          _supabase_logs
          ;;
        migration)
          _supabase_migration
          ;;
        migrations)
          _supabase_migrations
          ;;
        network-bans)
          _supabase_network_bans
          ;;
        network-restrictions)
          _supabase_network_restrictions
          ;;
        notebooks)
          _supabase_notebooks
          ;;
        orgs)
          _supabase_orgs
          ;;
        postgres-config)
          _supabase_postgres_config
          ;;
        projects)
          _supabase_projects
          ;;
        pull)
          _supabase_pull
          ;;
        secrets)
          _supabase_secrets
          ;;
        seed)
          _supabase_seed
          ;;
        services)
          _supabase_services
          ;;
        snippets)
          _supabase_snippets
          ;;
        ssl-enforcement)
          _supabase_ssl_enforcement
          ;;
        sso)
          _supabase_sso
          ;;
        start)
          _supabase_start
          ;;
        status)
          _supabase_status
          ;;
        stop)
          _supabase_stop
          ;;
        storage)
          _supabase_storage
          ;;
        telemetry)
          _supabase_telemetry
          ;;
        test)
          _supabase_test
          ;;
        unlink)
          _supabase_unlink
          ;;
        vanity-subdomains)
          _supabase_vanity_subdomains
          ;;
        whoami)
          _supabase_whoami
          ;;
      esac
      ;;
  esac
}

_supabase_backups() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:Lists available physical backups'
    'restore:Restore to a specific timestamp using PITR'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_backups_list
          ;;
        restore)
          _supabase_backups_restore
          ;;
      esac
      ;;
  esac
}

_supabase_backups_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_backups_restore() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--timestamp -t)--timestamp[The recovery time target in seconds since epoch.]:integer:'
    '(--timestamp -t)-t[The recovery time target in seconds since epoch.]:integer:'
  )
  _arguments "${specs[@]}"
}

_supabase_bootstrap() {
  local -a specs
  specs=(
    '(--password -p)--password[Password to your remote Postgres database.]:value:'
    '(--password -p)-p[Password to your remote Postgres database.]:value:'
    ':Name of the starter template to bootstrap from.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all preview branches'
    'create:Create a preview branch'
    'get:Retrieve details of a preview branch'
    'update:Update a preview branch'
    'pause:Pause a preview branch'
    'unpause:Unpause a preview branch'
    'delete:Delete a preview branch'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_branches_list
          ;;
        create)
          _supabase_branches_create
          ;;
        get)
          _supabase_branches_get
          ;;
        update)
          _supabase_branches_update
          ;;
        pause)
          _supabase_branches_pause
          ;;
        unpause)
          _supabase_branches_unpause
          ;;
        delete)
          _supabase_branches_delete
          ;;
      esac
      ;;
  esac
}

_supabase_branches_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_create() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--region)--region[Select a region to deploy the branch database.]:value:(ap-east-1 ap-northeast-1 ap-northeast-2 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 eu-central-1 eu-central-2 eu-north-1 eu-west-1 eu-west-2 eu-west-3 sa-east-1 us-east-1 us-east-2 us-west-1 us-west-2)'
    '(--size)--size[Select a desired instance size for the branch database.]:value:(large medium micro 12xlarge 16xlarge 24xlarge 24xlarge_high_memory 24xlarge_optimized_cpu 24xlarge_optimized_memory 2xlarge 48xlarge 48xlarge_high_memory 48xlarge_optimized_cpu 48xlarge_optimized_memory 4xlarge 8xlarge small xlarge)'
    '(--persistent --no-persistent)--persistent[Whether to create a persistent branch.]'
    '(--persistent --no-persistent)--no-persistent[Disable persistent]'
    '(--with-data --no-with-data)--with-data[Whether to clone production data to the branch database.]'
    '(--with-data --no-with-data)--no-with-data[Disable with-data]'
    '(--notify-url)--notify-url[URL to notify when branch is active healthy.]:value:'
    '(--git-branch)--git-branch[Associate a git branch with the new preview branch.]:value:'
    ':Name for the new branch.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Branch name or ID.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_update() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--name)--name[Rename the preview branch.]:value:'
    '(--git-branch)--git-branch[Change the associated git branch.]:value:'
    '(--persistent --no-persistent)--persistent[Switch between ephemeral and persistent branch.]'
    '(--persistent --no-persistent)--no-persistent[Disable persistent]'
    '(--status)--status[Override the current branch status.]:value:(RUNNING_MIGRATIONS MIGRATIONS_PASSED MIGRATIONS_FAILED FUNCTIONS_DEPLOYED FUNCTIONS_FAILED)'
    '(--notify-url)--notify-url[URL to notify when branch is active healthy.]:value:'
    ':Branch name or ID to update.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_pause() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Branch name or ID to pause.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_unpause() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Branch name or ID to unpause.:'
  )
  _arguments "${specs[@]}"
}

_supabase_branches_delete() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Branch name or ID to delete.:'
  )
  _arguments "${specs[@]}"
}

_supabase_completion() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'bash:Generate the autocompletion script for bash'
    'fish:Generate the autocompletion script for fish'
    'powershell:Generate the autocompletion script for powershell'
    'zsh:Generate the autocompletion script for zsh'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        bash)
          _supabase_completion_bash
          ;;
        fish)
          _supabase_completion_fish
          ;;
        powershell)
          _supabase_completion_powershell
          ;;
        zsh)
          _supabase_completion_zsh
          ;;
      esac
      ;;
  esac
}

_supabase_completion_bash() {
  local -a specs
  specs=(
    '(--no-descriptions --no-no-descriptions)--no-descriptions[disable completion descriptions]'
    '(--no-descriptions --no-no-descriptions)--no-no-descriptions[Disable no-descriptions]'
  )
  _arguments "${specs[@]}"
}

_supabase_completion_fish() {
  local -a specs
  specs=(
    '(--no-descriptions --no-no-descriptions)--no-descriptions[disable completion descriptions]'
    '(--no-descriptions --no-no-descriptions)--no-no-descriptions[Disable no-descriptions]'
  )
  _arguments "${specs[@]}"
}

_supabase_completion_powershell() {
  local -a specs
  specs=(
    '(--no-descriptions --no-no-descriptions)--no-descriptions[disable completion descriptions]'
    '(--no-descriptions --no-no-descriptions)--no-no-descriptions[Disable no-descriptions]'
  )
  _arguments "${specs[@]}"
}

_supabase_completion_zsh() {
  local -a specs
  specs=(
    '(--no-descriptions --no-no-descriptions)--no-descriptions[disable completion descriptions]'
    '(--no-descriptions --no-no-descriptions)--no-no-descriptions[Disable no-descriptions]'
  )
  _arguments "${specs[@]}"
}

_supabase_config() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'diff:Diff local config against a remote project'
    'pull:Pull remote config into the project config file'
    'push:Push local config to linked project'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        diff)
          _supabase_config_diff
          ;;
        pull)
          _supabase_config_pull
          ;;
        push)
          _supabase_config_push
          ;;
      esac
      ;;
  esac
}

_supabase_config_diff() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--exit-code --no-exit-code)--exit-code[Exit with status 2 when any difference is found (errors keep exiting 1).]'
    '(--exit-code --no-exit-code)--no-exit-code[Disable exit-code]'
  )
  _arguments "${specs[@]}"
}

_supabase_config_pull() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--remote-label)--remote-label[Name of the [remotes.*] block to write into, overriding the block config pull would otherwise reuse or create.]:value:'
    '(--dry-run --no-dry-run)--dry-run[Show what would be written without touching the config file.]'
    '(--dry-run --no-dry-run)--no-dry-run[Disable dry-run]'
    '(--force --no-force)--force[Write even when the project config file has uncommitted changes in git.]'
    '(--force --no-force)--no-force[Disable force]'
  )
  _arguments "${specs[@]}"
}

_supabase_config_push() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_db() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'diff:Diffs a database for schema changes'
    'dump:Dumps data or schemas from a database'
    'push:Push new migrations to a database'
    'pull:Pull schema from a database'
    'reset:Resets a database to current migrations'
    'lint:Checks a database for typing error'
    'start:Starts local Postgres database'
    'query:Execute a SQL query against the database'
    'advisors:Checks database for security and performance issues'
    'schema:Manage database schema'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        diff)
          _supabase_db_diff
          ;;
        dump)
          _supabase_db_dump
          ;;
        push)
          _supabase_db_push
          ;;
        pull)
          _supabase_db_pull
          ;;
        reset)
          _supabase_db_reset
          ;;
        lint)
          _supabase_db_lint
          ;;
        start)
          _supabase_db_start
          ;;
        query)
          _supabase_db_query
          ;;
        advisors)
          _supabase_db_advisors
          ;;
        schema)
          _supabase_db_schema
          ;;
      esac
      ;;
  esac
}

_supabase_db_diff() {
  local -a specs
  specs=(
    '(--use-migra --no-use-migra)--use-migra[Use migra to generate schema diff.]'
    '(--use-migra --no-use-migra)--no-use-migra[Disable use-migra]'
    '(--use-pgadmin --no-use-pgadmin)--use-pgadmin[Use pgAdmin to generate schema diff.]'
    '(--use-pgadmin --no-use-pgadmin)--no-use-pgadmin[Disable use-pgadmin]'
    '(--use-pg-delta --no-use-pg-delta)--use-pg-delta[Use pg-delta to generate schema diff.]'
    '(--use-pg-delta --no-use-pg-delta)--no-use-pg-delta[Disable use-pg-delta]'
    '(--strict-coverage --no-strict-coverage)--strict-coverage[Fail when bundled pg-delta finds schema objects it cannot manage instead of leaving them unmanaged.]'
    '(--strict-coverage --no-strict-coverage)--no-strict-coverage[Disable strict-coverage]'
    '(--from)--from[Diff from local, migrations, remote (always the linked project), a project ref, a branch, or a Postgres URL.]:value:'
    '(--to)--to[Diff to local, migrations, remote (always the linked project), a project ref, a branch, or a Postgres URL.]:value:'
    '(--output -o)--output[Write flattened explicit diff SQL to a file for review; this is not a portable apply script.]:value:'
    '(--output -o)-o[Write flattened explicit diff SQL to a file for review; this is not a portable apply script.]:value:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--file -f)--file[In normal mode, names and saves the complete schema diff as a new migration; it does not filter objects. Ignored with --from/--to.]:value:'
    '(--file -f)-f[In normal mode, names and saves the complete schema diff as a new migration; it does not filter objects. Ignored with --from/--to.]:value:'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_dump() {
  local -a specs
  specs=(
    '(--dry-run --no-dry-run)--dry-run[Prints the pg_dump script that would be executed.]'
    '(--dry-run --no-dry-run)--no-dry-run[Disable dry-run]'
    '(--data-only --no-data-only)--data-only[Dumps only data records.]'
    '(--data-only --no-data-only)--no-data-only[Disable data-only]'
    '(--use-copy --no-use-copy)--use-copy[Use copy statements in place of inserts.]'
    '(--use-copy --no-use-copy)--no-use-copy[Disable use-copy]'
    '(--exclude -x)--exclude[List of schema.tables to exclude from data-only dump.]:value:'
    '(--exclude -x)-x[List of schema.tables to exclude from data-only dump.]:value:'
    '(--role-only --no-role-only)--role-only[Dumps only cluster roles.]'
    '(--role-only --no-role-only)--no-role-only[Disable role-only]'
    '(--keep-comments --no-keep-comments)--keep-comments[Keeps commented lines from pg_dump output.]'
    '(--keep-comments --no-keep-comments)--no-keep-comments[Disable keep-comments]'
    '(--file -f)--file[File path to save the dumped contents.]:value:'
    '(--file -f)-f[File path to save the dumped contents.]:value:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_push() {
  local -a specs
  specs=(
    '(--include-all --no-include-all)--include-all[Include all migrations not found in the migration history table.]'
    '(--include-all --no-include-all)--no-include-all[Disable include-all]'
    '(--include-roles --no-include-roles)--include-roles[Include custom roles from supabase/roles.sql.]'
    '(--include-roles --no-include-roles)--no-include-roles[Disable include-roles]'
    '(--include-seed --no-include-seed)--include-seed[Include seed data from your config.]'
    '(--include-seed --no-include-seed)--no-include-seed[Disable include-seed]'
    '(--skip-vault --no-skip-vault)--skip-vault[Skip updating vault secrets from the config file.]'
    '(--skip-vault --no-skip-vault)--no-skip-vault[Disable skip-vault]'
    '(--dry-run --no-dry-run)--dry-run[Print the migrations that would be applied, but don'\''t actually apply them.]'
    '(--dry-run --no-dry-run)--no-dry-run[Disable dry-run]'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_pull() {
  local -a specs
  specs=(
    '(--declarative --no-declarative)--declarative[Replace the declarative schema tree from the selected database instead of creating a migration; migration history is not updated.]'
    '(--declarative --no-declarative)--no-declarative[Disable declarative]'
    '(--diff-engine)--diff-engine[Diff engine to use for migration-style db pull.]:value:(migra pg-delta)'
    '(--strict-coverage --no-strict-coverage)--strict-coverage[Fail when bundled pg-delta finds schema objects it cannot manage instead of leaving them unmanaged.]'
    '(--strict-coverage --no-strict-coverage)--no-strict-coverage[Disable strict-coverage]'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    ':Optional name for the migration file.:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_reset() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--no-seed --no-no-seed)--no-seed[Skip running the seed script after reset.]'
    '(--no-seed --no-no-seed)--no-no-seed[Disable no-seed]'
    '(--sql-paths)--sql-paths[Override db.seed.sql_paths for this reset. May be repeated; each value accepts a SQL file path or glob pattern relative to the supabase directory and force-enables seeding.]:value:'
    '(--version)--version[Reset up to the specified version.]:value:'
    '(--last)--last[Reset up to the last n migration versions.]:integer:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_lint() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
    '(--level)--level[Error level to emit.]:value:(warning error)'
    '(--fail-on)--fail-on[Error level to exit with non-zero status.]:value:(none warning error)'
  )
  _arguments "${specs[@]}"
}

_supabase_db_start() {
  local -a specs
  specs=(
    '(--from-backup)--from-backup[Path to a logical backup file.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_query() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--file -f)--file[Path to a SQL file to execute.]:value:'
    '(--file -f)-f[Path to a SQL file to execute.]:value:'
    '(--read-only --no-read-only)--read-only[Runs the statement in a read-only transaction; a hosted target needs no confirmation.]'
    '(--read-only --no-read-only)--no-read-only[Disable read-only]'
    ':SQL query to execute.:'
  )
  _arguments "${specs[@]}"
}

_supabase_db_advisors() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--type)--type[Type of advisors to check\: all, security, performance.]:value:(all security performance)'
    '(--level)--level[Minimum issue level to display\: info, warn, error.]:value:(info warn error)'
    '(--fail-on)--fail-on[Issue level to exit with non-zero status\: none, info, warn, error.]:value:(none info warn error)'
  )
  _arguments "${specs[@]}"
}

_supabase_db_schema() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'declarative:Manage declarative database schemas'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        declarative)
          _supabase_db_schema_declarative
          ;;
      esac
      ;;
  esac
}

_supabase_db_schema_declarative() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'sync:Generate a new migration from declarative schema'
    'generate:Generate declarative schema from a database'
  )

  local -a specs
  specs=(
    '(--no-cache --no-no-cache)--no-cache[Disable catalog cache and force fresh shadow database setup.]'
    '(--no-cache --no-no-cache)--no-no-cache[Disable no-cache]'
    '(--strict-coverage --no-strict-coverage)--strict-coverage[Fail when bundled pg-delta finds schema objects it cannot manage instead of leaving them unmanaged.]'
    '(--strict-coverage --no-strict-coverage)--no-strict-coverage[Disable strict-coverage]'
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        sync)
          _supabase_db_schema_declarative_sync
          ;;
        generate)
          _supabase_db_schema_declarative_generate
          ;;
      esac
      ;;
  esac
}

_supabase_db_schema_declarative_sync() {
  local -a specs
  specs=(
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
    '(--file -f)--file[Saves schema diff to a new migration file.]:value:'
    '(--file -f)-f[Saves schema diff to a new migration file.]:value:'
    '(--name)--name[Name for the generated migration file.]:value:'
    '(--apply --no-apply)--apply[Apply the generated migration to the local database without prompting.]'
    '(--apply --no-apply)--no-apply[Disable apply]'
    '(--no-apply --no-no-apply)--no-apply[Generate the migration file without prompting or applying it to the local database.]'
    '(--no-apply --no-no-apply)--no-no-apply[Disable no-apply]'
    '(--no-cache --no-no-cache)--no-cache[Disable catalog cache and force fresh shadow database setup.]'
    '(--no-cache --no-no-cache)--no-no-cache[Disable no-cache]'
    '(--strict-coverage --no-strict-coverage)--strict-coverage[Fail when bundled pg-delta finds schema objects it cannot manage instead of leaving them unmanaged.]'
    '(--strict-coverage --no-strict-coverage)--no-strict-coverage[Disable strict-coverage]'
  )
  _arguments "${specs[@]}"
}

_supabase_db_schema_declarative_generate() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--overwrite --no-overwrite)--overwrite[Overwrite declarative schema files without confirmation.]'
    '(--overwrite --no-overwrite)--no-overwrite[Disable overwrite]'
    '(--output-dir)--output-dir[Write the generated declarative schema to this directory without changing the configured declarative schema path.]:value:'
    '(--reset --no-reset)--reset[Reset local database before generating (local data will be lost).]'
    '(--reset --no-reset)--no-reset[Disable reset]'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--no-cache --no-no-cache)--no-cache[Disable catalog cache and force fresh shadow database setup.]'
    '(--no-cache --no-no-cache)--no-no-cache[Disable no-cache]'
    '(--strict-coverage --no-strict-coverage)--strict-coverage[Fail when bundled pg-delta finds schema objects it cannot manage instead of leaving them unmanaged.]'
    '(--strict-coverage --no-strict-coverage)--no-strict-coverage[Disable strict-coverage]'
  )
  _arguments "${specs[@]}"
}

_supabase_domains() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'create:Create a custom hostname'
    'get:Get the current custom hostname config'
    'reverify:Re-verify the custom hostname config'
    'activate:Activate the custom hostname for a project'
    'delete:Delete the custom hostname config'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        create)
          _supabase_domains_create
          ;;
        get)
          _supabase_domains_get
          ;;
        reverify)
          _supabase_domains_reverify
          ;;
        activate)
          _supabase_domains_activate
          ;;
        delete)
          _supabase_domains_delete
          ;;
      esac
      ;;
  esac
}

_supabase_domains_create() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--custom-hostname)--custom-hostname[The custom hostname to use for your Supabase project.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_domains_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_domains_reverify() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_domains_activate() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_domains_delete() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_encryption() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get-root-key:Get root encryption key'
    'update-root-key:Update the root encryption key'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get-root-key)
          _supabase_encryption_get_root_key
          ;;
        update-root-key)
          _supabase_encryption_update_root_key
          ;;
      esac
      ;;
  esac
}

_supabase_encryption_get_root_key() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_encryption_update_root_key() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_feedback() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'add:Send feedback to the Supabase team'
    'delete:Delete previously submitted feedback'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        add)
          _supabase_feedback_add
          ;;
        delete)
          _supabase_feedback_delete
          ;;
      esac
      ;;
  esac
}

_supabase_feedback_add() {
  local -a specs
  specs=(
    '(--project-ref)--project-ref[Project ref to attribute the feedback to (defaults to SUPABASE_PROJECT_ID, then the linked project).]:value:'
    '*:Freeform feedback. Bare words are joined with spaces. 1000 character limit.:'
  )
  _arguments "${specs[@]}"
}

_supabase_feedback_delete() {
  local -a specs
  specs=(
    '(--project-ref)--project-ref[Project ref of the Supabase project the feedback was submitted with.]:value:'
    ':Deletion token (UUID) printed when the feedback was submitted.:'
  )
  _arguments "${specs[@]}"
}

_supabase_functions() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all Functions in Supabase'
    'delete:Delete a Function from Supabase'
    'download:Download a Function from Supabase'
    'deploy:Deploy a Function to Supabase'
    'new:Create a new Function locally'
    'serve:Serve all Functions locally'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_functions_list
          ;;
        delete)
          _supabase_functions_delete
          ;;
        download)
          _supabase_functions_download
          ;;
        deploy)
          _supabase_functions_deploy
          ;;
        new)
          _supabase_functions_new
          ;;
        serve)
          _supabase_functions_serve
          ;;
      esac
      ;;
  esac
}

_supabase_functions_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_functions_delete() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Name of the Function to delete.:'
  )
  _arguments "${specs[@]}"
}

_supabase_functions_download() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--use-api --no-use-api)--use-api[Unbundle functions server-side without using Docker.]'
    '(--use-api --no-use-api)--no-use-api[Disable use-api]'
    ':Name of the Function to download. Downloads all if omitted.:'
  )
  _arguments "${specs[@]}"
}

_supabase_functions_deploy() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--no-verify-jwt --no-no-verify-jwt)--no-verify-jwt[Disable JWT verification for the Function.]'
    '(--no-verify-jwt --no-no-verify-jwt)--no-no-verify-jwt[Disable no-verify-jwt]'
    '(--use-api --no-use-api)--use-api[Bundle functions server-side without using Docker.]'
    '(--use-api --no-use-api)--no-use-api[Disable use-api]'
    '(--import-map)--import-map[Path to import map file.]:value:'
    '(--prune --no-prune)--prune[Delete Functions that exist in Supabase project but not locally.]'
    '(--prune --no-prune)--no-prune[Disable prune]'
    '(--jobs -j)--jobs[Maximum number of parallel jobs.]:integer:'
    '(--jobs -j)-j[Maximum number of parallel jobs.]:integer:'
    '*:Names of Functions to deploy. Deploys all if omitted.:'
  )
  _arguments "${specs[@]}"
}

_supabase_functions_new() {
  local -a specs
  specs=(
    '(--auth)--auth[use a specific auth mode]:value:(none apikey user)'
    ':Name of the Function to create.:'
  )
  _arguments "${specs[@]}"
}

_supabase_functions_serve() {
  local -a specs
  specs=(
    '(--no-verify-jwt --no-no-verify-jwt)--no-verify-jwt[Disable JWT verification for the Function.]'
    '(--no-verify-jwt --no-no-verify-jwt)--no-no-verify-jwt[Disable no-verify-jwt]'
    '(--env-file)--env-file[Path to an env file. Overrides supabase/functions/.env and per-Function .env files.]:value:'
    '(--import-map)--import-map[Path to import map file.]:value:'
    '(--inspect --no-inspect)--inspect[Alias of --inspect-mode brk.]'
    '(--inspect --no-inspect)--no-inspect[Disable inspect]'
    '(--inspect-mode)--inspect-mode[Activate inspector capability for debugging.]:value:(run brk wait)'
    '(--inspect-main --no-inspect-main)--inspect-main[Allow inspecting the main worker.]'
    '(--inspect-main --no-inspect-main)--no-inspect-main[Disable inspect-main]'
    '*:Legacy Function names. All Functions are served.:'
  )
  _arguments "${specs[@]}"
}

_supabase_gen() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'types:Generate types from Postgres schema'
    'signing-key:Generate a JWT signing key'
    'bearer-jwt:Generate a Bearer Auth JWT for accessing Data API'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        types)
          _supabase_gen_types
          ;;
        signing-key)
          _supabase_gen_signing_key
          ;;
        bearer-jwt)
          _supabase_gen_bearer_jwt
          ;;
      esac
      ;;
  esac
}

_supabase_gen_types() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--lang)--lang[Output language of the generated types. (default typescript)]:value:(typescript go python swift dart)'
    '(--schema -s)--schema[Comma separated list of schema to include.]:value:'
    '(--schema -s)-s[Comma separated list of schema to include.]:value:'
    '(--query-timeout)--query-timeout[Maximum timeout allowed for the database query. (default 15s)]:value:'
    '(--swift-access-control)--swift-access-control[Access control for Swift generated types. (default internal)]:value:(internal public)'
    ':language:'
  )
  _arguments "${specs[@]}"
}

_supabase_gen_signing_key() {
  local -a specs
  specs=(
    '(--algorithm)--algorithm[Algorithm for signing key generation.]:value:(ES256 RS256)'
    '(--append --no-append)--append[Append new key to existing keys file instead of overwriting.]'
    '(--append --no-append)--no-append[Disable append]'
  )
  _arguments "${specs[@]}"
}

_supabase_gen_bearer_jwt() {
  local -a specs
  specs=(
    '(--role)--role[Postgres role to use.]:value:'
    '(--sub)--sub[User ID to impersonate.]:value:'
    '(--exp)--exp[Expiry timestamp for this token.]:value:'
    '(--valid-for)--valid-for[Validity duration for this token.]:value:'
    '(--payload)--payload[Custom claims in JSON format.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_init() {
  local -a specs
  specs=(
    '(--interactive -i --no-interactive)--interactive[Enables interactive mode to configure IDE settings.]'
    '(--interactive -i --no-interactive)-i[Enables interactive mode to configure IDE settings.]'
    '(--interactive -i --no-interactive)--no-interactive[Disable interactive]'
    '(--use-orioledb --no-use-orioledb)--use-orioledb[Use OrioleDB storage engine for Postgres.]'
    '(--use-orioledb --no-use-orioledb)--no-use-orioledb[Disable use-orioledb]'
    '(--force --no-force)--force[Write a fresh supabase/config.toml, replacing an existing config.toml and removing any config.json or config.jsonc.]'
    '(--force --no-force)--no-force[Disable force]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'report:Generate a CSV output for all inspect commands'
    'db:Inspect database'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        report)
          _supabase_inspect_report
          ;;
        db)
          _supabase_inspect_db
          ;;
      esac
      ;;
  esac
}

_supabase_inspect_report() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--output-dir)--output-dir[Path to save CSV files in.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'db-stats:Show database stats'
    'replication-slots:Show replication slots'
    'locks:Show exclusive locks'
    'blocking:Show blocking queries'
    'outliers:Show query outliers by time'
    'calls:Show queries by call count'
    'index-stats:Show index stats'
    'collation-drift:Show indexes affected by collation version drift'
    'long-running-queries:Show long-running queries'
    'bloat:Show relation bloat'
    'role-stats:Show role stats'
    'vacuum-stats:Show vacuum stats'
    'table-stats:Show table stats'
    'traffic-profile:Show traffic profile'
    'toast-sizes:Show TOAST table sizes and dead chunk counts'
    'xid-age:Show XID age for user tables'
    'cache-hit:Show cache hit rates (deprecated)'
    'index-usage:Show index efficiency (deprecated)'
    'index-sizes:Show individual index sizes (deprecated)'
    'table-sizes:Show table sizes (deprecated)'
    'unused-indexes:Show unused indexes (deprecated)'
    'table-record-counts:Show table record counts (deprecated)'
    'seq-scans:Show sequential scans (deprecated)'
    'role-configs:Show role configs (deprecated)'
    'role-connections:Show role connections (deprecated)'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        db-stats)
          _supabase_inspect_db_db_stats
          ;;
        replication-slots)
          _supabase_inspect_db_replication_slots
          ;;
        locks)
          _supabase_inspect_db_locks
          ;;
        blocking)
          _supabase_inspect_db_blocking
          ;;
        outliers)
          _supabase_inspect_db_outliers
          ;;
        calls)
          _supabase_inspect_db_calls
          ;;
        index-stats)
          _supabase_inspect_db_index_stats
          ;;
        collation-drift)
          _supabase_inspect_db_collation_drift
          ;;
        long-running-queries)
          _supabase_inspect_db_long_running_queries
          ;;
        bloat)
          _supabase_inspect_db_bloat
          ;;
        role-stats)
          _supabase_inspect_db_role_stats
          ;;
        vacuum-stats)
          _supabase_inspect_db_vacuum_stats
          ;;
        table-stats)
          _supabase_inspect_db_table_stats
          ;;
        traffic-profile)
          _supabase_inspect_db_traffic_profile
          ;;
        toast-sizes)
          _supabase_inspect_db_toast_sizes
          ;;
        xid-age)
          _supabase_inspect_db_xid_age
          ;;
        cache-hit)
          _supabase_inspect_db_cache_hit
          ;;
        index-usage)
          _supabase_inspect_db_index_usage
          ;;
        index-sizes)
          _supabase_inspect_db_index_sizes
          ;;
        table-sizes)
          _supabase_inspect_db_table_sizes
          ;;
        unused-indexes)
          _supabase_inspect_db_unused_indexes
          ;;
        table-record-counts)
          _supabase_inspect_db_table_record_counts
          ;;
        seq-scans)
          _supabase_inspect_db_seq_scans
          ;;
        role-configs)
          _supabase_inspect_db_role_configs
          ;;
        role-connections)
          _supabase_inspect_db_role_connections
          ;;
      esac
      ;;
  esac
}

_supabase_inspect_db_db_stats() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_replication_slots() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_locks() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_blocking() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_outliers() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_calls() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_index_stats() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_collation_drift() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_long_running_queries() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_bloat() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_role_stats() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_vacuum_stats() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_table_stats() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_traffic_profile() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_toast_sizes() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_xid_age() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_cache_hit() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_index_usage() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_index_sizes() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_table_sizes() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_unused_indexes() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_table_record_counts() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_seq_scans() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_role_configs() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_inspect_db_role_connections() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_issue() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'bug:Open a bug report'
    'feature:Open a feature request'
    'docs:Open a documentation issue'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        bug)
          _supabase_issue_bug
          ;;
        feature)
          _supabase_issue_feature
          ;;
        docs)
          _supabase_issue_docs
          ;;
      esac
      ;;
  esac
}

_supabase_issue_bug() {
  local -a specs
  specs=(
    '(--area)--area[Affected CLI area.]:value:'
    '(--command)--command[Command that failed.]:value:'
    '(--actual-output)--actual-output[Actual output or error text.]:value:'
    '(--expected-behavior)--expected-behavior[Expected behavior.]:value:'
    '(--reproduce)--reproduce[Steps to reproduce.]:value:'
    '(--crash-report-id)--crash-report-id[Crash report or support ticket ID, if you have one.]:value:'
    '(--docker-services)--docker-services[Relevant Docker service status or logs.]:value:'
    '(--additional-context)--additional-context[Extra context to prefill on the issue form.]:value:'
    '(--no-browser --no-no-browser)--no-browser[Print the issue form URL without opening a browser.]'
    '(--no-browser --no-no-browser)--no-no-browser[Disable no-browser]'
  )
  _arguments "${specs[@]}"
}

_supabase_issue_feature() {
  local -a specs
  specs=(
    '(--existing-issues --no-existing-issues)--existing-issues[Prefill the existing issues checklist.]'
    '(--existing-issues --no-existing-issues)--no-existing-issues[Disable existing-issues]'
    '(--area)--area[Affected CLI area.]:value:'
    '(--problem)--problem[Problem the feature should solve.]:value:'
    '(--proposed-solution)--proposed-solution[Proposed solution.]:value:'
    '(--alternatives)--alternatives[Alternatives considered.]:value:'
    '(--additional-context)--additional-context[Extra context to prefill on the issue form.]:value:'
    '(--no-browser --no-no-browser)--no-browser[Print the issue form URL without opening a browser.]'
    '(--no-browser --no-no-browser)--no-no-browser[Disable no-browser]'
  )
  _arguments "${specs[@]}"
}

_supabase_issue_docs() {
  local -a specs
  specs=(
    '(--link)--link[Relevant documentation link.]:value:'
    '(--issue-type)--issue-type[Documentation issue type.]:value:'
    '(--problem)--problem[What is confusing, missing, or incorrect.]:value:'
    '(--improvement)--improvement[Suggested documentation improvement.]:value:'
    '(--additional-context)--additional-context[Extra context to prefill on the issue form.]:value:'
    '(--no-browser --no-no-browser)--no-browser[Print the issue form URL without opening a browser.]'
    '(--no-browser --no-no-browser)--no-no-browser[Disable no-browser]'
  )
  _arguments "${specs[@]}"
}

_supabase_link() {
  local -a specs
  specs=(
    '(--project-ref)--project-ref[Project ref of the Supabase project, or the name of one of its branches.]:value:'
    '(--skip-pooler --no-skip-pooler)--skip-pooler[Use direct connection instead of pooler.]'
    '(--skip-pooler --no-skip-pooler)--no-skip-pooler[Disable skip-pooler]'
    ':Project ref, or the name (or UUID) of a branch of the currently linked project. Values that are exactly 20 lowercase letters are always treated as project refs.:'
  )
  _arguments "${specs[@]}"
}

_supabase_login() {
  local -a specs
  specs=(
    '(--token)--token[Use provided token instead of automatic login flow.]:value:'
    '(--name)--name[Name that will be used to store token in your settings.]:value:'
    '(--no-browser --no-no-browser)--no-browser[Do not open browser automatically.]'
    '(--no-browser --no-no-browser)--no-no-browser[Disable no-browser]'
  )
  _arguments "${specs[@]}"
}

_supabase_logout() {
}

_supabase_logs() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'sources:List supported sources and filters. Hosted entries describe capabilities and do not imply that rows exist. Local entries list retained stack instances. Use --output-format json|stream-json for structured output; -o/--output is unsupported.'
  )

  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote log source\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--stack)--stack[Select a local stack by name.]:value:'
    '(--stack-id)--stack-id[Select a local stack by ID.]:value:'
    '(--service)--service[Service selector; repeat for multiple services. See logs sources.]:value:'
    '(--resource)--resource[Compute name or function ID remotely, or a local instance ID.]:value:'
    '(--kind)--kind[Compute stream; requires --service compute.]:value:(app requests builds)'
    '(--level)--level[Severity filter; repeat for several levels.]:value:(error warn warning info debug log notice)'
    '(--search)--search[Case-insensitive message substring (hosted only).]:value:'
    '(--since)--since[Duration or UTC timestamp; defaults to 1h. Local stacks also accept start.]:value:'
    '(--from)--from[Start at a UTC timestamp ending in Z.]:value:'
    '(--to)--to[Initial end at a UTC timestamp ending in Z. L advances to now.]:value:'
    '(--limit)--limit[Initial filtered history count (default 100, maximum 1000). SQL controls its own LIMIT.]:integer:'
    '(--sql)--sql[Custom hosted log SQL; requires --remote. L reruns the query.]:value:'
    '(--file)--file[Read custom hosted log SQL from a file; use - to read stdin.]:value:'
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        sources)
          _supabase_logs_sources
          ;;
      esac
      ;;
  esac
}

_supabase_logs_sources() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote log source\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--stack)--stack[Select a local stack by name.]:value:'
    '(--stack-id)--stack-id[Select a local stack by ID.]:value:'
    '(--service)--service[Describe one service.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_migration() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List local files and the target database'\''s migration history'
    'new:Create an empty migration script'
    'repair:Repair the migration history table'
    'squash:Squash migrations to a single file'
    'up:Apply pending migrations to a database'
    'down:Resets applied migrations up to the last n versions'
    'fetch:Fetch migration files from history table'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_migration_list
          ;;
        new)
          _supabase_migration_new
          ;;
        repair)
          _supabase_migration_repair
          ;;
        squash)
          _supabase_migration_squash
          ;;
        up)
          _supabase_migration_up
          ;;
        down)
          _supabase_migration_down
          ;;
        fetch)
          _supabase_migration_fetch
          ;;
      esac
      ;;
  esac
}

_supabase_migration_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_new() {
  local -a specs
  specs=(
    ':Name for the new migration file.:'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_repair() {
  local -a specs
  specs=(
    '(--status)--status[Version status to update.]:value:(applied reverted)'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '*:Migration version(s) to repair.:'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_squash() {
  local -a specs
  specs=(
    '(--version)--version[Squash up to the specified version.]:value:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_up() {
  local -a specs
  specs=(
    '(--include-all --no-include-all)--include-all[Include all migrations not found in the migration history table.]'
    '(--include-all --no-include-all)--no-include-all[Disable include-all]'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_down() {
  local -a specs
  specs=(
    '(--last)--last[Reset up to the last n migration versions.]:integer:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_migration_fetch() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List local files and the target database'\''s migration history'
    'new:Create an empty migration script'
    'repair:Repair the migration history table'
    'squash:Squash migrations to a single file'
    'up:Apply pending migrations to a database'
    'down:Resets applied migrations up to the last n versions'
    'fetch:Fetch migration files from history table'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_migrations_list
          ;;
        new)
          _supabase_migrations_new
          ;;
        repair)
          _supabase_migrations_repair
          ;;
        squash)
          _supabase_migrations_squash
          ;;
        up)
          _supabase_migrations_up
          ;;
        down)
          _supabase_migrations_down
          ;;
        fetch)
          _supabase_migrations_fetch
          ;;
      esac
      ;;
  esac
}

_supabase_migrations_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_new() {
  local -a specs
  specs=(
    ':Name for the new migration file.:'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_repair() {
  local -a specs
  specs=(
    '(--status)--status[Version status to update.]:value:(applied reverted)'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '*:Migration version(s) to repair.:'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_squash() {
  local -a specs
  specs=(
    '(--version)--version[Squash up to the specified version.]:value:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--password -p)--password[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
    '(--password -p)-p[Database password for the project selected with --remote. Not used for the local database or a database URL.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_up() {
  local -a specs
  specs=(
    '(--include-all --no-include-all)--include-all[Include all migrations not found in the migration history table.]'
    '(--include-all --no-include-all)--no-include-all[Disable include-all]'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_down() {
  local -a specs
  specs=(
    '(--last)--last[Reset up to the last n migration versions.]:integer:'
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_migrations_fetch() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_network_bans() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get:Get the current network bans'
    'remove:Remove a network ban'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get)
          _supabase_network_bans_get
          ;;
        remove)
          _supabase_network_bans_remove
          ;;
      esac
      ;;
  esac
}

_supabase_network_bans_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_network_bans_remove() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--db-unban-ip)--db-unban-ip[IP to allow DB connections from.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_network_restrictions() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get:Get the current network restrictions'
    'update:Update network restrictions'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get)
          _supabase_network_restrictions_get
          ;;
        update)
          _supabase_network_restrictions_update
          ;;
      esac
      ;;
  esac
}

_supabase_network_restrictions_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_network_restrictions_update() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--db-allow-cidr)--db-allow-cidr[CIDR to allow DB connections from.]:value:'
    '(--bypass-cidr-checks --no-bypass-cidr-checks)--bypass-cidr-checks[Bypass some of the CIDR validation checks.]'
    '(--bypass-cidr-checks --no-bypass-cidr-checks)--no-bypass-cidr-checks[Disable bypass-cidr-checks]'
    '(--append --no-append)--append[Append to existing restrictions instead of replacing them.]'
    '(--append --no-append)--no-append[Disable append]'
  )
  _arguments "${specs[@]}"
}

_supabase_notebooks() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'push:Push notebooks to Supabase'
    'pull:Pull notebooks from Supabase'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        push)
          _supabase_notebooks_push
          ;;
        pull)
          _supabase_notebooks_pull
          ;;
      esac
      ;;
  esac
}

_supabase_notebooks_push() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Name of the notebook to push. Pushes all if omitted.:'
  )
  _arguments "${specs[@]}"
}

_supabase_notebooks_pull() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':UUID of the notebook to replace locally. Pulls only locally missing notebooks if omitted.:'
  )
  _arguments "${specs[@]}"
}

_supabase_orgs() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all organizations'
    'create:Create an organization'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_orgs_list
          ;;
        create)
          _supabase_orgs_create
          ;;
      esac
      ;;
  esac
}

_supabase_orgs_list() {
}

_supabase_orgs_create() {
  local -a specs
  specs=(
    ':Display name for the new organization.:'
  )
  _arguments "${specs[@]}"
}

_supabase_postgres_config() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get:Get Postgres database config'
    'update:Update Postgres database config'
    'delete:Delete Postgres database config overrides'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get)
          _supabase_postgres_config_get
          ;;
        update)
          _supabase_postgres_config_update
          ;;
        delete)
          _supabase_postgres_config_delete
          ;;
      esac
      ;;
  esac
}

_supabase_postgres_config_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_postgres_config_update() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--config)--config[Config overrides specified as a '\''key=value'\'' pair]:value:'
    '(--replace-existing-overrides --no-replace-existing-overrides)--replace-existing-overrides[If true, replaces all existing overrides with the ones provided. If false (default), merges existing overrides with the ones provided.]'
    '(--replace-existing-overrides --no-replace-existing-overrides)--no-replace-existing-overrides[Disable replace-existing-overrides]'
    '(--no-restart --no-no-restart)--no-restart[Do not restart the database after updating config.]'
    '(--no-restart --no-no-restart)--no-no-restart[Disable no-restart]'
  )
  _arguments "${specs[@]}"
}

_supabase_postgres_config_delete() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--config)--config[Config keys to delete (comma-separated)]:value:'
    '(--no-restart --no-no-restart)--no-restart[Do not restart the database after deleting config.]'
    '(--no-restart --no-no-restart)--no-no-restart[Disable no-restart]'
  )
  _arguments "${specs[@]}"
}

_supabase_projects() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all projects'
    'create:Create a project'
    'api-keys:List API keys'
    'delete:Delete a project'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_projects_list
          ;;
        create)
          _supabase_projects_create
          ;;
        api-keys)
          _supabase_projects_api_keys
          ;;
        delete)
          _supabase_projects_delete
          ;;
      esac
      ;;
  esac
}

_supabase_projects_list() {
}

_supabase_projects_create() {
  local -a specs
  specs=(
    '(--org-id)--org-id[Organization ID to create the project in.]:value:'
    '(--db-password)--db-password[Database password of the project.]:value:'
    '(--region)--region[Select a region close to you for the best performance.]:value:(ap-east-1 ap-northeast-1 ap-northeast-2 ap-south-1 ap-southeast-1 ap-southeast-2 ca-central-1 eu-central-1 eu-central-2 eu-north-1 eu-west-1 eu-west-2 eu-west-3 sa-east-1 us-east-1 us-east-2 us-west-1 us-west-2)'
    '(--size)--size[Select a desired instance size for your project.]:value:(large medium micro 12xlarge 16xlarge 24xlarge 24xlarge_high_memory 24xlarge_optimized_cpu 24xlarge_optimized_memory 2xlarge 48xlarge 48xlarge_high_memory 48xlarge_optimized_cpu 48xlarge_optimized_memory 4xlarge 8xlarge small xlarge)'
    '(--high-availability --no-high-availability)--high-availability[Enable high availability for the project.]'
    '(--high-availability --no-high-availability)--no-high-availability[Disable high-availability]'
    ':Name of the project to create.:'
  )
  _arguments "${specs[@]}"
}

_supabase_projects_api_keys() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--reveal --no-reveal)--reveal[Reveal the secret API keys in full (e.g. sb_secret_...).]'
    '(--reveal --no-reveal)--no-reveal[Disable reveal]'
  )
  _arguments "${specs[@]}"
}

_supabase_projects_delete() {
  local -a specs
  specs=(
    ':Project ref to delete.:'
  )
  _arguments "${specs[@]}"
}

_supabase_pull() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--remote-label)--remote-label[Name of the [remotes.*] block the config step writes into, overriding the block it would otherwise reuse or create.]:value:'
    '(--dry-run --no-dry-run)--dry-run[Show what would be pulled without writing or changing anything.]'
    '(--dry-run --no-dry-run)--no-dry-run[Disable dry-run]'
    '(--force --no-force)--force[Write even when the project config file, supabase/migrations, or supabase/functions has uncommitted or untracked changes in git.]'
    '(--force --no-force)--no-force[Disable force]'
    '(--with-migration-history --no-with-migration-history)--with-migration-history[Fetch the remote migration history table into supabase/migrations, even when it already has files. Runs automatically when supabase/migrations is missing or empty.]'
    '(--with-migration-history --no-with-migration-history)--no-with-migration-history[Disable with-migration-history]'
  )
  _arguments "${specs[@]}"
}

_supabase_secrets() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all secrets on Supabase'
    'set:Set a secret(s) on Supabase'
    'unset:Unset a secret(s) on Supabase'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_secrets_list
          ;;
        set)
          _supabase_secrets_set
          ;;
        unset)
          _supabase_secrets_unset
          ;;
      esac
      ;;
  esac
}

_supabase_secrets_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_secrets_set() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--env-file)--env-file[Read secrets from a .env file.]:value:'
    '*:Secret name=value pairs to set.:'
  )
  _arguments "${specs[@]}"
}

_supabase_secrets_unset() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--all --no-all)--all[Unset every secret except SUPABASE_ ones. Required when no names are given.]'
    '(--all --no-all)--no-all[Disable all]'
    '(--dry-run --no-dry-run)--dry-run[Print the secrets that would be unset without unsetting them.]'
    '(--dry-run --no-dry-run)--no-dry-run[Disable dry-run]'
    '*:Secret names to unset.:'
  )
  _arguments "${specs[@]}"
}

_supabase_seed() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'buckets:Seed buckets declared in storage.buckets'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        buckets)
          _supabase_seed_buckets
          ;;
      esac
      ;;
  esac
}

_supabase_seed_buckets() {
}

_supabase_services() {
}

_supabase_snippets() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all SQL snippets'
    'download:Download contents of a SQL snippet'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_snippets_list
          ;;
        download)
          _supabase_snippets_download
          ;;
      esac
      ;;
  esac
}

_supabase_snippets_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_snippets_download() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':ID of the SQL snippet to download.:'
  )
  _arguments "${specs[@]}"
}

_supabase_ssl_enforcement() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get:Get SSL enforcement configuration'
    'update:Update SSL enforcement configuration'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get)
          _supabase_ssl_enforcement_get
          ;;
        update)
          _supabase_ssl_enforcement_update
          ;;
      esac
      ;;
  esac
}

_supabase_ssl_enforcement_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_ssl_enforcement_update() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--enable-db-ssl-enforcement --no-enable-db-ssl-enforcement)--enable-db-ssl-enforcement[Whether the DB should enable SSL enforcement for all external connections.]'
    '(--enable-db-ssl-enforcement --no-enable-db-ssl-enforcement)--no-enable-db-ssl-enforcement[Disable enable-db-ssl-enforcement]'
    '(--disable-db-ssl-enforcement --no-disable-db-ssl-enforcement)--disable-db-ssl-enforcement[Whether the DB should disable SSL enforcement for all external connections.]'
    '(--disable-db-ssl-enforcement --no-disable-db-ssl-enforcement)--no-disable-db-ssl-enforcement[Disable disable-db-ssl-enforcement]'
  )
  _arguments "${specs[@]}"
}

_supabase_sso() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'list:List all SSO identity providers'
    'add:Add a new SSO identity provider'
    'remove:Remove an existing SSO identity provider'
    'update:Update information about an SSO identity provider'
    'show:Show information about an SSO identity provider'
    'info:Returns the SAML SSO settings required for the identity provider'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        list)
          _supabase_sso_list
          ;;
        add)
          _supabase_sso_add
          ;;
        remove)
          _supabase_sso_remove
          ;;
        update)
          _supabase_sso_update
          ;;
        show)
          _supabase_sso_show
          ;;
        info)
          _supabase_sso_info
          ;;
      esac
      ;;
  esac
}

_supabase_sso_list() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_sso_add() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--type -t)--type[Type of identity provider (according to supported protocol).]:value:(saml)'
    '(--type -t)-t[Type of identity provider (according to supported protocol).]:value:(saml)'
    '(--domains)--domains[Comma separated list of email domains to associate with the added identity provider.]:value:'
    '(--metadata-file)--metadata-file[File containing a SAML 2.0 Metadata XML document describing the identity provider.]:value:'
    '(--metadata-url)--metadata-url[URL pointing to a SAML 2.0 Metadata XML document describing the identity provider.]:value:'
    '(--skip-url-validation --no-skip-url-validation)--skip-url-validation[Skip local validation of the SAML 2.0 Metadata URL (HTTPS requirement, live GET probe, and UTF-8 body decode). Use in air-gapped CI where the IDP is not reachable from the build agent.]'
    '(--skip-url-validation --no-skip-url-validation)--no-skip-url-validation[Disable skip-url-validation]'
    '(--attribute-mapping-file)--attribute-mapping-file[File containing a JSON mapping between SAML attributes to custom JWT claims.]:value:'
    '(--name-id-format)--name-id-format[URI reference representing the classification of string-based identifier information.]:value:(urn\:oasis\:names\:tc\:SAML\:1.1\:nameid-format\:emailAddress urn\:oasis\:names\:tc\:SAML\:1.1\:nameid-format\:unspecified urn\:oasis\:names\:tc\:SAML\:2.0\:nameid-format\:persistent urn\:oasis\:names\:tc\:SAML\:2.0\:nameid-format\:transient)'
  )
  _arguments "${specs[@]}"
}

_supabase_sso_remove() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':The ID of the SSO identity provider to remove.:'
  )
  _arguments "${specs[@]}"
}

_supabase_sso_update() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--domains)--domains[Replace domains with this comma separated list of email domains.]:value:'
    '(--add-domains)--add-domains[Add this comma separated list of email domains to the identity provider.]:value:'
    '(--remove-domains)--remove-domains[Remove this comma separated list of email domains from the identity provider.]:value:'
    '(--metadata-file)--metadata-file[File containing a SAML 2.0 Metadata XML document describing the identity provider.]:value:'
    '(--metadata-url)--metadata-url[URL pointing to a SAML 2.0 Metadata XML document describing the identity provider.]:value:'
    '(--skip-url-validation --no-skip-url-validation)--skip-url-validation[Skip local validation of the SAML 2.0 Metadata URL (HTTPS requirement, live GET probe, and UTF-8 body decode). Use in air-gapped CI where the IDP is not reachable from the build agent.]'
    '(--skip-url-validation --no-skip-url-validation)--no-skip-url-validation[Disable skip-url-validation]'
    '(--attribute-mapping-file)--attribute-mapping-file[File containing a JSON mapping between SAML attributes to custom JWT claims.]:value:'
    '(--name-id-format)--name-id-format[URI reference representing the classification of string-based identifier information.]:value:(urn\:oasis\:names\:tc\:SAML\:1.1\:nameid-format\:emailAddress urn\:oasis\:names\:tc\:SAML\:1.1\:nameid-format\:unspecified urn\:oasis\:names\:tc\:SAML\:2.0\:nameid-format\:persistent urn\:oasis\:names\:tc\:SAML\:2.0\:nameid-format\:transient)'
    ':The ID of the SSO identity provider to update.:'
  )
  _arguments "${specs[@]}"
}

_supabase_sso_show() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--metadata --no-metadata)--metadata[Show SAML 2.0 XML Metadata only]'
    '(--metadata --no-metadata)--no-metadata[Disable metadata]'
    ':The ID of the SSO identity provider to show.:'
  )
  _arguments "${specs[@]}"
}

_supabase_sso_info() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_start() {
  local -a specs
  specs=(
    '(--exclude -x)--exclude[Names of containers to not start. [gotrue,realtime,storage-api,imgproxy,kong,mailpit,postgrest,postgres-meta,studio,edge-runtime,logflare,vector,supavisor]]:value:'
    '(--exclude -x)-x[Names of containers to not start. [gotrue,realtime,storage-api,imgproxy,kong,mailpit,postgrest,postgres-meta,studio,edge-runtime,logflare,vector,supavisor]]:value:'
    '(--ignore-health-check --no-ignore-health-check)--ignore-health-check[Ignore unhealthy services and exit 0]'
    '(--ignore-health-check --no-ignore-health-check)--no-ignore-health-check[Disable ignore-health-check]'
  )
  _arguments "${specs[@]}"
}

_supabase_status() {
  local -a specs
  specs=(
    '(--override-name)--override-name[Override specific variable names.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_stop() {
  local -a specs
  specs=(
    '(--project-id)--project-id[Local project ID to stop.]:value:'
    '(--no-backup --no-no-backup)--no-backup[Deletes all data volumes after stopping.]'
    '(--no-backup --no-no-backup)--no-no-backup[Disable no-backup]'
    '(--all --no-all)--all[Stop all local Supabase instances from all projects across the machine.]'
    '(--all --no-all)--no-all[Disable all]'
  )
  _arguments "${specs[@]}"
}

_supabase_storage() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'ls:List objects by path prefix'
    'cp:Copy objects from src to dst path'
    'mv:Move objects from src to dst path'
    'rm:Remove objects by file path'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        ls)
          _supabase_storage_ls
          ;;
        cp)
          _supabase_storage_cp
          ;;
        mv)
          _supabase_storage_mv
          ;;
        rm)
          _supabase_storage_rm
          ;;
      esac
      ;;
  esac
}

_supabase_storage_ls() {
  local -a specs
  specs=(
    '(--recursive -r --no-recursive)--recursive[Recursively list a directory.]'
    '(--recursive -r --no-recursive)-r[Recursively list a directory.]'
    '(--recursive -r --no-recursive)--no-recursive[Disable recursive]'
    '(--remote --no-remote)--remote[Target a remote Storage API\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Storage path to list (e.g. ss\:///bucket/docs).:'
  )
  _arguments "${specs[@]}"
}

_supabase_storage_cp() {
  local -a specs
  specs=(
    '(--recursive -r --no-recursive)--recursive[Recursively copy a directory.]'
    '(--recursive -r --no-recursive)-r[Recursively copy a directory.]'
    '(--recursive -r --no-recursive)--no-recursive[Disable recursive]'
    '(--cache-control)--cache-control[Custom Cache-Control header for HTTP upload. (default "max-age=3600")]:value:'
    '(--content-type)--content-type[Custom Content-Type header for HTTP upload. (default "auto-detect")]:value:'
    '(--jobs -j)--jobs[Maximum number of parallel jobs. (default 1)]:value:'
    '(--jobs -j)-j[Maximum number of parallel jobs. (default 1)]:value:'
    '(--remote --no-remote)--remote[Target a remote Storage API\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Source path to copy from.:'
    ':Destination path to copy to.:'
  )
  _arguments "${specs[@]}"
}

_supabase_storage_mv() {
  local -a specs
  specs=(
    '(--recursive -r --no-recursive)--recursive[Recursively move a directory.]'
    '(--recursive -r --no-recursive)-r[Recursively move a directory.]'
    '(--recursive -r --no-recursive)--no-recursive[Disable recursive]'
    '(--remote --no-remote)--remote[Target a remote Storage API\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    ':Source path to move from.:'
    ':Destination path to move to.:'
  )
  _arguments "${specs[@]}"
}

_supabase_storage_rm() {
  local -a specs
  specs=(
    '(--recursive -r --no-recursive)--recursive[Recursively remove a directory.]'
    '(--recursive -r --no-recursive)-r[Recursively remove a directory.]'
    '(--recursive -r --no-recursive)--no-recursive[Disable recursive]'
    '(--remote --no-remote)--remote[Target a remote Storage API\: the linked project, or --remote=<ref|branch>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '*:File paths to remove.:'
  )
  _arguments "${specs[@]}"
}

_supabase_telemetry() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'enable:Enable telemetry'
    'disable:Disable telemetry'
    'status:Show telemetry status'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        enable)
          _supabase_telemetry_enable
          ;;
        disable)
          _supabase_telemetry_disable
          ;;
        status)
          _supabase_telemetry_status
          ;;
      esac
      ;;
  esac
}

_supabase_telemetry_enable() {
}

_supabase_telemetry_disable() {
}

_supabase_telemetry_status() {
}

_supabase_test() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'db:Tests a database with pgTAP'
    'new:Create a new test file'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        db)
          _supabase_test_db
          ;;
        new)
          _supabase_test_new
          ;;
      esac
      ;;
  esac
}

_supabase_test_db() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target a remote database\: the linked project, or --remote=<ref|branch|url>.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '*:Paths to test files or directories.:'
  )
  _arguments "${specs[@]}"
}

_supabase_test_new() {
  local -a specs
  specs=(
    '(--template -t)--template[Template framework to generate.]:value:(pgtap)'
    '(--template -t)-t[Template framework to generate.]:value:(pgtap)'
    ':Name of the test file to create.:'
  )
  _arguments "${specs[@]}"
}

_supabase_unlink() {
}

_supabase_vanity_subdomains() {
  local context state state_descr line
  typeset -A opt_args

  local -a commands
  commands=(
    'get:Get the current vanity subdomain'
    'check-availability:Check subdomain availability'
    'activate:Activate a vanity subdomain'
    'delete:Delete the vanity subdomain'
  )

  local -a specs
  specs=(
    '1:command:->command'
    '*::arg:->args'
  )

  _arguments -C "${specs[@]}"

  case "$state" in
    command)
      _describe -t commands 'commands' commands
      ;;
    args)
      case "$words[1]" in
        get)
          _supabase_vanity_subdomains_get
          ;;
        check-availability)
          _supabase_vanity_subdomains_check_availability
          ;;
        activate)
          _supabase_vanity_subdomains_activate
          ;;
        delete)
          _supabase_vanity_subdomains_delete
          ;;
      esac
      ;;
  esac
}

_supabase_vanity_subdomains_get() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_vanity_subdomains_check_availability() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--desired-subdomain)--desired-subdomain[The desired vanity subdomain to use for your Supabase project.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_vanity_subdomains_activate() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
    '(--desired-subdomain)--desired-subdomain[The desired vanity subdomain to use for your Supabase project.]:value:'
  )
  _arguments "${specs[@]}"
}

_supabase_vanity_subdomains_delete() {
  local -a specs
  specs=(
    '(--remote --no-remote)--remote[Target another project\: --remote=<ref|branch>. Defaults to the linked project.]'
    '(--remote --no-remote)--no-remote[Disable remote]'
  )
  _arguments "${specs[@]}"
}

_supabase_whoami() {
}

# Handle both direct invocation and autoload
if [[ "${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _supabase "$@"
else
  compdef _supabase supabase
fi
###-end-supabase-completions-###
