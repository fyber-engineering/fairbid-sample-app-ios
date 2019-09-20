use_frameworks!

platform :ios, '8.0'

target 'Fyber FairBid' do
  pod 'FairBidSDK', '2.1.1'
  pod 'SwiftLint'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
			cflags << '-fembed-bitcode'

			config.build_settings['OTHER_CFLAGS'] = cflags
		end
	end
end
