Pod::Spec.new do |s|
    s.name         = "RollbarCrashReport"
    s.version      = "3.0.0"
    s.summary      = "Application or client side SDK for interacting with the Rollbar API Server."
    s.description  = <<-DESC
                      Find, fix, and resolve errors with Rollbar.
                      Easily send error data using Rollbar API.
                      Analyze, de-dupe, send alerts, and prepare the data for further analysis.
                      Search, sort, and prioritize via the Rollbar dashboard.
                  DESC

    s.homepage     = "https://rollbar.com"
    s.resource     = "rollbar-logo.png"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = { "Rollbar" => "support@rollbar.com" }
    s.source       = { :git => "https://github.com/rollbar/rollbar-apple.git",
                      :tag => s.version.to_s }
    s.documentation_url = "https://docs.rollbar.com/docs/apple"
    s.social_media_url  = "https://twitter.com/rollbar"

    s.osx.deployment_target = "12.0"
    s.ios.deployment_target = "14.0"
    s.tvos.deployment_target = "14.0"
    s.watchos.deployment_target = "8.0"

    s.module_name = "RollbarCrashReport"
    s.dependency "KSCrash", "~> 1.15"
    s.frameworks = "Foundation"
    s.source_files  = "RollbarNotifier/Sources/RollbarCrashReport/**/*.swift"
end
