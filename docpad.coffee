# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig =

  # Template Data
  # =============
  # These are variables that will be accessible via our templates
  # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

  templateData:

    # Specify some site properties
    site:
      # The production url of our website
      url: "http://elasticsearch-kr.github.io"

      # The default title of our website
      title: "Elasticsearch Korea"

      # The website description (for SEO)
      description: """
        Elasticsearch Korea
        """

      # The website keywords (for SEO) separated by commas
      keywords: """
        elasticsearch, elasticsearch-kr, elasticsearch korea, community
        """

      # The website author's name
      author: "Daniel Ku"

      # The website author's email
      email: "kjunine@gmail.com"

      # Google analytics configuration
      google: {
        analytics: {
          trackingId: 'UA-50192388-2'
        }
      }

    # Helper Functions
    # ----------------

    # Get the prepared site/document title
    # Often we would like to specify particular formatting to our page's title
    # we can apply that formatting here
    getPreparedTitle: ->
      # if we have a document title, then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} | #{@site.title}"
      # if our document does not have it's own title, then we should just use the site's title
      else
        @site.title

    # Get the prepared site/document description
    getPreparedDescription: ->
      # if we have a document description, then we should use that, otherwise use the site's description
      @document.description or @site.description

    # Get the prepared site/document keywords
    getPreparedKeywords: ->
      # Merge the document keywords with the site keywords
      @site.keywords.concat(@document.keywords or []).join(', ')


  # Collections
  # ===========
  # These are special collections that our website makes available to us

  collections:
    # For instance, this one will fetch in all documents that have pageOrder set within their meta data
    pages: (database) ->
      database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

    # This one, will fetch in all documents that will be outputted to the posts directory
    posts: (database) ->
      database.findAllLive({relativeOutDirPath:'posts'},[date:-1])

    # This one, will fetch in all documents that will be outputted to the presentations directory
    presentations: (database) ->
      database.findAllLive({relativeOutDirPath:'presentations'},[date:-1])

  # Plugin Configuration
  # =================================

  # Configure Plugins
  # Should contain the plugin short names on the left, and the configuration to pass the plugin on the right
  plugins:
    ghpages:
      deployRemote: 'target'
      deployBranch: 'master'

# Export our DocPad Configuration
module.exports = docpadConfig
