import Config

config :contactsapp, Contactsapp.Repo,
  database: System.get_env("DATABASE_NAME"),
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASSWORD"),
  hostname: System.get_env("DATABASE_HOST"),
  pool_size: 2,
  port: System.get_env("DATABASE_PORT")

  config :contactsapp, service_port: System.get_env("DATABASE_SERVICE_PORT")
  config :contactsapp, service_ip: {10,136,168,7}
