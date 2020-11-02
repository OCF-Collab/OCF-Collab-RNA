OCFCollabClient = OAuth2::Client.new(
  ENV["OCF_COLLAB_CLIENT_ID"],
  ENV["OCF_COLLAB_CLIENT_SECRET"],
  site: ENV["OCF_COLLAB_URL"],
)
