# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

MY_PN="Flask-Security-Too"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="This is an independently maintained version of Flask-Security based on the 3.0.0 version of the Original flask-security"
HOMEPAGE="https://pypi.org/project/Flask-Security-Too/"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/flask-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/flask-principal-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-wtf-0.14.2[${PYTHON_USEDEP}]
	>=dev-python/flask-babelex-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/python-email-validator-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.7.2[${PYTHON_USEDEP}]
"

BDEPEND="${RDEPEND}
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/twine[${PYTHON_USEDEP}]
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-runner-5.2[${PYTHON_USEDEP}]
		>=dev-python/flask-mail-0.9.1[${PYTHON_USEDEP}]
		>=dev-python/flask-mongoengine-0.9.5[${PYTHON_USEDEP}]
		>=dev-python/peewee-3.11.2[${PYTHON_USEDEP}]
		>=dev-python/argon2_cffi-19.1.0[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		>=dev-python/flask-sqlalchemy-2.3[${PYTHON_USEDEP}]
		dev-python/bcrypt[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_test() {
	nosetests -v || die "Testing failed with ${EPYTHON}"
}
