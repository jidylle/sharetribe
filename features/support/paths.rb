module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the signup page/
      '/en/signup'
    when /the private community sign in page/
      '/en/homepage/sign_in'
    when /the english private community sign in page/
      '/en/homepage/sign_in'  
    when /the requests page/
      '/en/requests'
    when /the offers page/
      '/en/offers'
    when /the login page/
      login_path(:locale => "en")
    when /the edit listing page/
      edit_listing_path(:id => @listing.id, :locale => "en") 
    when /^the give feedback path of "(.*)"$/i
      new_person_message_feedback_path(:person_id => @people[$1].id, :message_id => @conversation.id.to_s, :locale => "en")
    when /^the conversation path of "(.*)"$/i
      person_message_path(:person_id => @people[$1].id, :id => @conversation.id.to_s, :locale => "en")
    when /^the profile page of "(.*)"$/i
      person_path(:id => @people[$1].id, :locale => "en")
    when /^my profile page$/i
      person_path(:id => @logged_in_user.id, :locale => "en")
    when /^the badges page of "(.*)"$/i
      person_badges_path(:person_id => @people[$1].id, :locale => "en")
    when /^the testimonials page of "(.*)"$/i
      person_testimonials_path(:person_id => @people[$1].id, :locale => "en")
    when /the listing page/
      listing_path(:id => @listing.id, :locale => "en")
    when /^the registration page with invitation code "(.*)"$/i
      "/en/signup?code=#{$1}"
    when /the infos page/
      about_infos_path(:locale => "en")
    when /the news page/
      news_items_path(:locale => "en")
    when /new tribe in English/
      new_tribe_path(:community_locale => "en", :locale => "en")
    when /invitations page$/i
      new_invitation_path(:locale => "en")
    # the following are examples using path_to_pickle

    when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
      path_to_pickle $1

    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
      path_to_pickle $1, $2

    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
      path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page

    when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
      path_to_pickle $1, :extra => $2                               #  or the forum's edit page
    

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)