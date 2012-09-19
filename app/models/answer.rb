class Answer < Entry

  belongs_to :post

  field :post_id, type: Integer

  def answer_url
    "http://wally.redu.com.br/answers/#{self.id}"
  end
end
