module Internal
  def self.version
    critical = 0 # Broken backwards compatibility of public interface
                 # Production code based on previous releases maybe be broken by this release
    major = 1 # Changed public interface. No backwards compatibility issues.
              # Production code based on previous releases should not present any issues after upgrade.
              # Production code based on this release may be broken when using previous releases.
    minor = 0 # Changed internal interface
              # There should be no impact on third party software
              # Library extensions using library internal interface may be broken. 
    patch = nil # Changed private interface (protected and/or private methods). Bug fixes. Refactoring. 
                # Patch needs to increase for each commit. Patch is a three digits figure.
                # No side effects of any sort should be detected
    alpha = 2 # First phase of development of new major or critical release
    beta = nil # release candidate for first critical release (v0.9.0, v1.0.0.0beta1, v1.0.0)
    pre_release = nil # release candidate of new minor releases
    release_candidate = nil # Used before releasing new major or critical releases

    version = "#{critical}.#{major}.#{minor}"

    if patch
      version += ".#{'%03d' % patch}"
    elsif pre_release
      version += "pre#{'%02d' % pre_release}"
    elsif release_candidate
      version += "rc#{release_candidate}"
    elsif alpha
      version += "alpha#{'%02d' % alpha}"
    elsif beta
      version += "beta#{beta}"
    end
    version
  end


  VERSION = version
end
