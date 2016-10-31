package HPEOneView::Models::Storage::StorageVolumes;


use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw($json_create_volume);
our @EXPORT = qw($json_create_volume);

our $json_create_volume = <<'END_JSON';
{
  "name": "",
  "description": "",
  "templateUri": null,
  "snapshotPoolUri": "",
  "provisioningParameters": {
    "storagePoolUri": "",
    "requestedCapacity": "1073741824",
    "provisionType": "Thin",
    "shareable": false
  }
}
END_JSON
