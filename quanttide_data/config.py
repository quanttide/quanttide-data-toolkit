from dynaconf import Dynaconf


settings = Dynaconf(
    settings_files=['default_settings.yml'],
)
