# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
    pod 'Alamofire'
    pod 'Moya'
    pod 'Nuke'
end

target 'Reddit' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Reddit
  
  shared_pods

  target 'RedditTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'RedditComponents' do

  use_frameworks!
  # Pods for RedditComponents
  
  shared_pods

end
