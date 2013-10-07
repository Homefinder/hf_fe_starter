# Some of these helpers operate on hashes with string (NOT symbol) keys that
# come directly from lib/homefinder, our HTTParty wrapper around the homefinder
# API
#
# TODO: move these into instance methods of lib/homefinder
module HomesHelper

  DATETIMEFORMAT = '%m/%d/%Y'

  def listing_date(str)
    Date.parse(str).strftime(DATETIMEFORMAT)
  end

  # Rails 3.2 uses Ordered Hashes, so we can retrieve the k,v pairs in the order they were inserted
  def address_parts(address)
    return {} unless address

    {
      line1:    address['line1'],
      line2:    address['line2'],
      city:     address['city'],
      state:    address['state'],
      zip:      address['zip']
    }.keep_if { |k, v| v.present? }
  end

  def one_line_address(address)
    format_address address_parts(address)
  end

  def google_maps_address(address)
    format_address address_parts(address).except(:line2)
  end

  def format_address(parts)
    [
      parts.except(:zip).values.join(', '),
      parts[:zip]
    ].keep_if{ |v| v.present? }.join(' ')
  end

  def link_to_google_maps(address, text = nil)
    return unless formatted_address = google_maps_address(address)

    text ||= 'View in Google Maps'
    url = 'https://maps.google.com/maps?q=' + CGI::escape(formatted_address)

    link_to text, url
  end

  def link_to_homefinder_url(url)
    return unless url

    text ||= "View on Homefinder.com"

    link_to text, url
  end

  def link_to_external_url(link_hash)
    return unless link_hash
    return unless text = link_hash["label"]
    return unless url  = link_hash["url"]

    link_to text, url
  end

  def offsite_links(listing)
    [
      link_to_homefinder_url( listing["url"]         ),
      link_to_google_maps(    listing["address"]     ),
      link_to_external_url(   listing["externalUrl"] )
    ].keep_if{ |v| v.present? }
  end

  def offsite_links_markup(listing)
    return unless links = offsite_links(listing)

    content_tag :ul, safe_join(links.map{ |link| content_tag(:li, link) })
  end

  def listing_description(listing)
    return "No description available" unless description = listing["description"]

    description
  end

  def listing_image(listing)
    return unless hsh = listing["primaryPhoto"]
    return unless url = hsh["url"]

    image_tag url, alt: one_line_address(listing["address"])
  end

  def listing_price(listing)
    return "Unknown" unless price = listing["price"]

    number_to_currency price, precision: 0
  end
end
