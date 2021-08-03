from pygments import highlight
from pygments.lexers import StanLexer
from pygments.formatters import HtmlFormatter
from IPython.core.display import HTML

def show_stan_model(stan_file, lines=None):
    """
    Show stan model code with syntax highlighting in Jupyter notebooks
    """
    with open(stan_file) as f:
        code = f.read()
        if lines is not None:
            f, l = lines
            code = '\n'.join(code.split('\n')[f-1:l])
    display(HTML(highlight(code, StanLexer(), HtmlFormatter(full=True))))