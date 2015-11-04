Given that we have a simple CRUD app with Paperclip
- [Album has_attached_file :cover_art](https://github.com/choonkeat/paperclip_to_attache/blob/05ec43f60fe4dfbc55d84872698b2d5f7ca41ad3/app/models/album.rb#L2)
- [Album has_many :images](https://github.com/choonkeat/paperclip_to_attache/blob/05ec43f60fe4dfbc55d84872698b2d5f7ca41ad3/app/models/album.rb#L5)
- [Image has_attached_file :file](https://github.com/choonkeat/paperclip_to_attache/blob/05ec43f60fe4dfbc55d84872698b2d5f7ca41ad3/app/models/image.rb#L2)

We can [upgrade to attache](https://github.com/choonkeat/paperclip_to_attache/commit/a1f5d5b4cd90565dcaa3ad7cda3b348bf73c808e) while keeping all the S3 files intact and in place.
- add `attache_rails` to Gemfile
- add json columns to tables
- populate json columns with existing paperclip urls & metadata
- use `has_one_attache` and/or `has_many_attaches` in model
- use `*_url` and/or `*_urls` helper methods to render `image_tag` instead
- update strong params

After the upgrade is applied (and `db:migrate` is done) then we an look to [remove paperclip gem, aws gem and S3 config](https://github.com/choonkeat/paperclip_to_attache/commit/7a6a75dfbf3632386c3f5cb595bced3c05f40e81)

We can also look to [enable attache js](https://github.com/choonkeat/paperclip_to_attache/commit/060c6927842bbe7a6f74e25ba93af7ea4971bb11) to make browser upload faster (directly to attache, instead of uploading the files to your rails app)
