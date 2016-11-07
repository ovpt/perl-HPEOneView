package HPEOneView::Uris::Storage;


use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our $STORAGE_SYSTEMS = '/rest/storage-systems';
our $STORAGE_POOLS = '/rest/storage-pools';
our $STORAGE_VOLUMES = '/rest/storage-volumes';
our $STORAGE_VOLUME_TEMPLATES = '/rest/storage-volume-templates';
our $STORAGE_VOLUME_ATTACHMENTS = '/rest/storage-volume-attachments';

our $SAN_MANAGERS = '/rest/fc-sans/device-managers';
our $MANAGED_SANS = '/rest/fc-sans/managed-sans';
