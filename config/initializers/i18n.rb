module UseKeyForMissing
  def call(exception, locale, key, options)
    if exception.is_a?(I18n::MissingTranslation)
      key
    else
      super
    end
  end
end

I18n.exception_handler.extend UseKeyForMissing
