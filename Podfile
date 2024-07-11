# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'HushCo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HushCo
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  
  pod 'Alamofire', '~> 5.4'
  
  end

post_install do |installer|
  find_replace = "find ./Pods/Target\\ Support\\ Files/leveldb-library/ -type f -name '*.h' -exec sed -i '' 's/\"c.h\"/<c.h>/g' {} +"
  system(find_replace)
end


