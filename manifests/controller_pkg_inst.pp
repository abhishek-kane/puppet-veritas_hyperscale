# == Class: controller_pkg_inst
#
# === Variables
#
# [operation]
#   install/uninstall
#
# === Example
#
#   class {'veritas_hyperscale::controller_pkg_inst':
#       operation => "install",
#   }
#
# === Authors
#
# Veritas HyperScale CI <DL-VTAS-ENG-SDIO-HyperScale-Opensource@veritas.com>
#
# === Copyright
#
# Copyright (c) 2017 Veritas Technologies LLC.
#

class veritas_hyperscale::controller_pkg_inst (
	$operation = $operation,
)inherits veritas_hyperscale
{
    require veritas_hyperscale

	if $operation == "install" {
		$op = "installed"
	}
	else {
		$op = "absent"
	}

	if $platform == "redhat" {
		$provider1 = "yum"
		package { 'VRTSofcore':
			ensure   => $op,
			provider => 'rpm',
			source   => "$path/packages/VRTSofcore-1.1.0.000-RHEL7.x86_64.rpm",
			}

		package { 'VRTSofmn':
			ensure   => $op,
			provider => 'rpm',
			source   => "$path/packages/VRTSofmn-1.1.0.000-RHEL7.x86_64.rpm",
			require  => Package["VRTSofcore"],
			}

		package { 'VRTSofspt':
			ensure   => $op,
			provider => 'rpm',
			source   => "$path/packages/VRTSofspt_1.0.0.100-RHEL7.x86_64.rpm",
			}
	}
	else {
		$provider1 = "apt"
		package { 'vrtsofcore':
			ensure   => $op,
			provider => 'dpkg',
			source   => "$path/packages/vrtsofcore_1.0.0.100-UBUNTU16_amd64.deb",
			}

		package { 'vrtsofmn':
			ensure   => $op,
			provider => 'dpkg',
			source   => "$path/packages/vrtsofmn_1.0.0.100-UBUNTU16_amd64.deb",
			require  => Package["vrtsofcore"],
			}

		package { 'vrtsofspt':
			ensure   => $op,
			provider => 'dpkg',
			source   => "$path/packages/vrtsofspt_1.0.0.100-UBUNTU16_amd64.deb",
			}

		package { 'ipcalc':
			ensure   => installed,
			provider => $provider1,
			}

		package { 'dpkg-dev':
			ensure   => installed,
			provider => $provider1,
			}

		package { 'python-mysqldb':
			ensure   => installed,
			provider => $provider1,
			}

		package { 'libcurl4-openssl-dev':
			ensure   => installed,
			provider => $provider1,
			}
	}

	package { 'rabbitmq-server':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'crudini':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'python-amqp':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'python-kombu':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'python-kazoo':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'python-anyjson':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'python-sqlalchemy':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'lvm2':
		ensure   => installed,
		provider => $provider1,
		}

	package { 'coreutils':
		ensure   => installed,
		provider => $provider1,
		}
}
