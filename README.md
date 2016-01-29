# masala_haproxy

This is a component of the [masala toolkit](https://github.com/PaytmLabs/masala).

This is a [wrapper cookbook](http://blog.vialstudios.com/the-environment-cookbook-pattern/#thewrappercookbook) for providing recipes for haproxy server deployment. It also allows the option of enabling keepalived to allow for a virtual IP to run across a redundant pair of systems. It can do this in AWS, with an optional elastic ip follow.

It will enable datadog monitoring for haproxy if enabled in masala_base.

## Supported Platforms

The platforms supported are:
- Centos 6.7+ / Centos 7.1+
- Ubuntu 14.04 LTS (And future LTS releases)
- Debioan 8.2+

## Attributes

Please see the documentation for the cookbooks included by masala_haproxy. (See [metadata.rb](https://github.com/PaytmLabs/masala_haproxy/blob/develop/metadata.rb) file)

All of these values pass through to keepalived and only apply to the master and backup recipes, which include the keepalived support. To skip keepalived, just use the default recipe.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['masala_haproxy']['keepalive_password']</tt></td>
    <td>String</td>
    <td>password for securing keepalive co-ordination</td>
    <td><tt>abc123</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_haproxy']['keepalive_vi_1']</tt></td>
    <td>Hash</td>
    <td>keepalived virtual interface definition - primary.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_haproxy']['keepalive_vi_2']</tt></td>
    <td>Hash</td>
    <td>keepalived virtual interface definition - secondary.</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Usage

### masala_haproxy::default

Include `masala_haproxy` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[masala_haproxy::default]"
  ]
}
```

## License, authors, and how to contribute

See:
- [LICENSE](https://github.com/PaytmLabs/masala_haproxy/blob/develop/LICENSE)
- [MAINTAINERS.md](https://github.com/PaytmLabs/masala_haproxy/blob/develop/MAINTAINERS.md)
- [CONTRIBUTING.md](https://github.com/PaytmLabs/masala_haproxy/blob/develop/CONTRIBUTING.md)

