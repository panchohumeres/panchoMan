# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))
master_doc = 'index'

# -- Project information -----------------------------------------------------

project = 'Manual Docker'
copyright = '2020, Francisco Humeres M.'
author = 'Francisco Humeres M.'

# The full version, including alpha/beta/rc tags
release = '1.0'


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = 'es'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'alabaster'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']



rst_prolog = """
panchoMan |panchoman| panchoMan GitHub Repo |github| panchoMan Kibana GitLab Repo |gitlab|

.. |panchoman| image:: https://panchoman.s3-sa-east-1.amazonaws.com/panthom_logo.png
    :target: https://panchohumeres.github.io/panchoMan
    :height: 20
    :width: 20

.. |github| image:: https://panchoman.s3-sa-east-1.amazonaws.com/GitHub-Mark-32px.png
    :target: https://github.com/panchohumeres/panchoMan
    :height: 20
    :width: 20

.. |gitlab| image:: https://panchoman.s3-sa-east-1.amazonaws.com/gitlab-logo-white-stacked-rgb_small.png
    :target: https://gitlab.com/panchohumeres/docker_man_page
    :height: 20
    :width: 20
"""
rst_epilog = """

---------------------------------------------------------------

.. raw:: html

    <embed>
    <a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Licencia Creative Commons" style="border-width:0;" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /> Esta obra está bajo una <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Licencia Creative Commons Atribución 4.0 Internacional </a>

    </embed>
"""