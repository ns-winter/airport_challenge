require 'plane'
describe Plane do

  before do
    allow_any_instance_of(Weather).to receive(:status) { "sunny" }
  end

  it 'expects plane to be airborne' do
    plane1 = Plane.new("Test_plane")
    expect(plane1.status == 'airborne').to eq true
  end

  it 'expects to land in airport' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    plane1.land(airport1)
    expect(plane1.status == 'grounded').to eq true
  end

  it 'expects to take off from airport' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    plane1.land(airport1)
    plane1.take_off(airport1)
    expect(plane1.status == 'airborne').to eq true
    expect(airport1.planes == []).to eq true
  end

  it 'expects not to land in airport' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    plane1.land(airport1)
    expect(plane1.land(airport1) == "Test_plane already on the ground").to eq true
  end

  it 'expects not to allow take off if plane isn\'t present' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    expect(plane1.take_off(airport1) == "Take Off not possible: Test_plane not present").to eq true
  end

  it 'expects the plane not to take off due to weather' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    plane1.land(airport1)
    allow_any_instance_of(Weather).to receive(:status) { "stormy" }
    expect(plane1.take_off(airport1) == "Take Off aborted: Inclement weather").to eq true
  end

end

context Plane do

  before do
    allow_any_instance_of(Weather).to receive(:status) { "stormy" }
  end

  it 'expects not to land in airport' do
    plane1 = Plane.new("Test_plane")
    airport1 = Airport.new("Test_port")
    plane1.land(airport1)
    expect(plane1.status == 'grounded').to eq false
  end

end
