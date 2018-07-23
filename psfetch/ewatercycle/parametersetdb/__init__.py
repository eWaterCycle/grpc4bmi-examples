import configparser
from subprocess import check_call

import requests


class CaseConfigParser(configparser.ConfigParser):
    """Case sensitive config parser

    See https://stackoverflow.com/questions/1611799/preserve-case-in-configparser
    """
    def optionxform(self, optionstr):
        return optionstr


class Parameterset():
    config_source = 'https://github.com/UU-Hydro/PCR-GLOBWB_input_example/raw/master/RhineMeuse30min/ini_and_batch_files/rapid/setup_natural_test.ini'
    datafiles_source = 'https://github.com/UU-Hydro/PCR-GLOBWB_input_example/trunk/RhineMeuse30min'

    def __init__(self):
        self._init_config()

    def save_datafiles(self, target):
        check_call(['svn', 'export', self.datafiles_source, target])

    def _init_config(self):
        self.config = CaseConfigParser()
        r = requests.get(self.config_source)
        r.raise_for_status()
        self.config.read_string(r.text)

    def save_config(self, fn):
        with open(fn, 'w') as f:
            self.config.write(f)


class Parametersetdb():
    def select(self, model, name):
        if model == 'PCR-GLOBWB' and name == 'RhineMeuse30min':
            return Parameterset()
        else:
            raise FileNotFoundError()
