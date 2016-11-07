describe 'rspec2' do
  it 'popメソッドを呼ぶと配列の要素が減少することをテスト' do
    #x = [1, 2, 3]
    #expect(x.size).to eq 3
    #x.pop
    #expect(x.size).to eq 2

x = [1, 2, 3]
expect{ x.pop }.to change{ x.size }.from(3).to(2)
  end
end


