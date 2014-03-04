# Changelog

## 1.1.0

- Iterate over hashes as well, if a block is given. Previously hashes were not
  iterated over, so that they could be used as values. But they can actually be
  safely iterated over when a block is given.

## 1.0.0

No changes. This release is just to mark the gem as stable. It has
been running without failure for several months.
