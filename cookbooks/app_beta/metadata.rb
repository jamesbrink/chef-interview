name             'app_beta'
maintainer       'Liftopia'
maintainer_email 'ops@liftopia.com'
license          'All rights reserved'
description      'Installs/Configures app_beta'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

depends 'ruby'
depends 'nodejs'
depends 'redis'
depends 'mongodb'
depends 'memcached'
depends 'mysql'
depends 'supervisor'
depends 'nginx'


