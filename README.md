About oracle-jdk-dummy
======================

Home: https://github.com/phreed/oracle-jdk-dummy-feedstock

Package license: MIT

Feedstock license: [BSD-3-Clause](https://github.com/phreed/oracle-jdk-dummy-feedstock/blob/v8/LICENSE.txt)

Summary: Meta-package for Oracle JDK

Development: https://github.com/phreed/oracle-jdk-dummy-feedstock

Documentation: https://github.com/phreed/oracle-jdk-dummy-feedstock

This module provides a dummy installer for the Oracle JDK.
It does not install the Oracle JDK package.
It adds the Oracle JDK into the specified Conda environment.
It expects the appropriate Oracle JDK to have been previously acquired.
It may be acquired and installed from
https://www.oracle.com/java/technologies/downloads/#java8-windows
https://www.oracle.com/java/technologies/downloads/#java8-linux


Current build status
====================


<table>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-oracle--jdk--dummy-green.svg)](https://anaconda.org/mesomorph/oracle-jdk-dummy) | [![Conda Downloads](https://img.shields.io/conda/dn/mesomorph/oracle-jdk-dummy.svg)](https://anaconda.org/mesomorph/oracle-jdk-dummy) | [![Conda Version](https://img.shields.io/conda/vn/mesomorph/oracle-jdk-dummy.svg)](https://anaconda.org/mesomorph/oracle-jdk-dummy) | [![Conda Platforms](https://img.shields.io/conda/pn/mesomorph/oracle-jdk-dummy.svg)](https://anaconda.org/mesomorph/oracle-jdk-dummy) |

Installing oracle-jdk-dummy
===========================

Installing `oracle-jdk-dummy` from the `mesomorph` channel can be achieved by adding `mesomorph` to your channels with:

```
conda config --add channels mesomorph
conda config --set channel_priority strict
```

Once the `mesomorph` channel has been enabled, `oracle-jdk-dummy` can be installed with `conda`:

```
conda install oracle-jdk-dummy
```

or with `mamba`:

```
mamba install oracle-jdk-dummy
```

It is possible to list all of the versions of `oracle-jdk-dummy` available on your platform with `conda`:

```
conda search oracle-jdk-dummy --channel mesomorph
```

or with `mamba`:

```
mamba search oracle-jdk-dummy --channel mesomorph
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search oracle-jdk-dummy --channel mesomorph

# List packages depending on `oracle-jdk-dummy`:
mamba repoquery whoneeds oracle-jdk-dummy --channel mesomorph

# List dependencies of `oracle-jdk-dummy`:
mamba repoquery depends oracle-jdk-dummy --channel mesomorph
```




Updating oracle-jdk-dummy-feedstock
===================================

If you would like to improve the oracle-jdk-dummy recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`mesomorph` channel, whereupon the built conda packages will be available for
everybody to install and use from the `mesomorph` channel.
Note that all branches in the phreed/oracle-jdk-dummy-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@phreed](https://github.com/phreed/)

