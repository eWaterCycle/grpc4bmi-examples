import configparser
from subprocess import check_call

import requests


class CaseConfigParser(configparser.ConfigParser):
    """Case sensitive config parser

    See https://stackoverflow.com/questions/1611799/preserve-case-in-configparser
    """
    def optionxform(self, optionstr):
        return optionstr


class SubversionCopier:
    def __init__(self, source):
        self.source = source

    def save(self, target):
        check_call(['svn', 'export', self.source, target])


def fetch(url):
    """Fetches text of url"""
    r = requests.get(url)
    r.raise_for_status()
    return r.text


class IniConfig:
    config = CaseConfigParser(strict=False)

    def __init__(self, source):
        body = fetch(source)
        self.config.read_string(body)

    def save(self, target):
        with open(target, 'w') as f:
            self.config.write(f)


class Parameterset:
    def __init__(self, df, cfg):
        self.df = df
        self.cfg = cfg

    def save_datafiles(self, target):
        self.df.save(target)

    def save_config(self, target):
        self.cfg.save(target)

    @property
    def config(self):
        return self.cfg.config


class Parametersetdb():
    def select(self, model, name):
        if model == 'PCR-GLOBWB' and name == 'RhineMeuse30min':
            return Parameterset(
                SubversionCopier('https://github.com/UU-Hydro/PCR-GLOBWB_input_example/trunk/RhineMeuse30min'),
                IniConfig(
                    'https://github.com/UU-Hydro/PCR-GLOBWB_input_example/raw/master/RhineMeuse30min/ini_and_batch_files/rapid/setup_natural_test.ini'
                )
            )
        elif model == 'wflow' and name == 'wflow_rhine_sbm':
            return Parameterset(
                SubversionCopier('https://github.com/openstreams/wflow/trunk/examples/wflow_rhine_sbm'),
                IniConfig(
                    'https://github.com/openstreams/wflow/raw/master/examples/wflow_rhine_sbm/wflow_sbm.ini'
                )
            )
        else:
            raise FileNotFoundError()
