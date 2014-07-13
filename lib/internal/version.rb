module Internal
  def self.version
    # Any third party software should rely only on current major version
    # Any release under the current major release should be good.
    # Use: gem 'internal', '~> 1.0'
    #
    # Any extension to the current gem should rely only on current major and minor release.
    # A Change to the major or minor release can brake the extension
    # Usage: gem 'internal', '~> 1.1.0'
    major = 0 # Broken backwards compatibility of public interface
              # Production code based on previous releases maybe be broken by this release
    minor = 1 # Changed public interface. No backwards compatibility issues.
              # Production code based on previous releases should not present any issues after upgrade.
              # Production code based on this release may be broken when using previous releases.
              # Changes to internal interface with broken backwards compatibility
              # Library extensions may be broken 
    teeny = 0 # Changed internal interface with backward compatibility
              # There should be no impact on third party software
              # Library extensions using library internal interface are not broken. 
              # Changed private interface (protected and/or private methods). Bug fixes. Refactoring. 
              # No side effects of any sort should be detected
    alpha = 2 # First phase of development of new major, minor or patch release
    release_candidate = nil # Used before releasing new minor or major releases

    "#{major}.#{minor}.#{teeny}" << if alpha
      ".alpha.#{alpha}"
    elsif release_candidate
      ".rc.#{release_candidate}"
    end
  end

  VERSION = version.freeze
end
