platform :ios, '13.0'

target 'DT FairBid' do
  use_frameworks!
  project "DT FairBid"
  pod 'FairBidSDK', '3.55.0'
end

target 'DT SwiftUI' do
  use_frameworks!
  project "DT FairBid"
  pod 'FairBidSDK', '3.55.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end
