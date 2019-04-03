platform :ios, '8.0'

target 'Fyber FairBid' do
	pod 'FairBidSDK', '2.0.0' 

	pod 'mopub-ios-sdk', '5.5.0', :inhibit_warnings => true
	pod 'Google-Mobile-Ads-SDK', '7.42.0'
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

