# puppet-komea-foundation

Manage Komea Foundation via puppet.

## Usage

```puppet
    class { 'komea_foundation': }
```

#### Parameters

##### `ksf_fqdn`

Komea Foundation fully qualified domain name. Valid option: string. Default value: "localhost".

##### `superuser_login`

The superuser login. Valid option: string. Default value: "ksfuser".

##### `superuser_password`

The superuser passowrd. Valid option: string. Default value: "password".

##### `dashboard_metrics_url`

The dashboard metrics URL. Valid option: string. Default value: "undef".

##### `resources_static_locations`

The directory containing the extra static resources exposed by Foundation. Valid option: string. Default vaule: "file:/opt/echoes/foundation/resources/".

##### `root_ca_content`

The root CA certificate content.Valid option: string. Default value: "undef".

##### `ksf_security_internal_remember_token`

The KSF Securtity internal remamber token. Valid option: string. Default value: "undef".
