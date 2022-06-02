%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from contracts.token.ERC721.ERC721_base import (
    ERC721_name,
    ERC721_symbol,
    ERC721_balanceOf,
    ERC721_ownerOf,
    ERC721_getApproved,
    ERC721_isApprovedForAll,
    ERC721_mint,
    ERC721_burn,
    ERC721_initializer,
    ERC721_approve,
    ERC721_setApprovalForAll,
    ERC721_transferFrom,
    ERC721_safeTransferFrom
)

#
# Constant
#

# 0x03b56add608787daa56932f92c6afbeb50efdd78d63610d9a904aae351b6de73
const EVALUATOR = 1677475417901394056918510239904556747001047725760406288169598737081332850291

# 0x066b68aab8212add0a549b7332191a49d836a736d0e778568288dbfd25a8af97
const PLAYER = 2903652111632991046251083850907328949501570059565591292027248478929526763415

#
# Private vars
#

@storage_var
func animal_attributes(rank : felt, attr : felt) -> (value : felt):
end

#
# Constructor
#

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        name : felt, symbol : felt, to_ : felt):
    ERC721_initializer(name, symbol)
    let to = to_
    let token_id : Uint256 = Uint256(1, 0)
    ERC721_mint(to, token_id)
    return ()
end

#
# Getters
#

@view
func name{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (name : felt):
    let (name) = ERC721_name()
    return (name)
end

@view
func symbol{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (symbol : felt):
    let (symbol) = ERC721_symbol()
    return (symbol)
end

@view
func balanceOf{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(owner : felt) -> (
        balance : Uint256):
    let (balance : Uint256) = ERC721_balanceOf(owner)
    return (balance)
end

@view
func ownerOf{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        token_id : Uint256) -> (owner : felt):
    let (owner : felt) = ERC721_ownerOf(token_id)
    return (owner)
end

@view
func getApproved{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        token_id : Uint256) -> (approved : felt):
    let (approved : felt) = ERC721_getApproved(token_id)
    return (approved)
end

@view
func isApprovedForAll{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        owner : felt, operator : felt) -> (is_approved : felt):
    let (is_approved : felt) = ERC721_isApprovedForAll(owner, operator)
    return (is_approved)
end

@view
func get_animal_characteristics{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(token_id : Uint256) -> (sex : felt, legs : felt, wings : felt):
    alloc_locals
    let rank = token_id.low
    let (sex) = animal_attributes.read(rank, 0)
    if sex == 0:
        let (sex) = IEvaluator.assigned_sex_number(contract_address=EVALUATOR, player_address=PLAYER)
        let (legs) = IEvaluator.assigned_legs_number(contract_address=EVALUATOR, player_address=PLAYER)
        let (wings) = IEvaluator.assigned_wings_number(contract_address=EVALUATOR, player_address=PLAYER)
        return (sex, legs, wings)
    else:
        let (legs) = animal_attributes.read(rank, 1)
        let (wings) = animal_attributes.read(rank, 2)
        return (sex, legs, wings)
    end
end

#
# Externals
#

@external
func approve{pedersen_ptr : HashBuiltin*, syscall_ptr : felt*, range_check_ptr}(
        to : felt, token_id : Uint256):
    ERC721_approve(to, token_id)
    return ()
end

@external
func setApprovalForAll{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        operator : felt, approved : felt):
    ERC721_setApprovalForAll(operator, approved)
    return ()
end

@external
func transferFrom{pedersen_ptr : HashBuiltin*, syscall_ptr : felt*, range_check_ptr}(
        _from : felt, to : felt, token_id : Uint256):
    ERC721_transferFrom(_from, to, token_id)
    return ()
end

@external
func safeTransferFrom{pedersen_ptr : HashBuiltin*, syscall_ptr : felt*, range_check_ptr}(
        _from : felt, to : felt, token_id : Uint256, data_len : felt, data : felt*):
    ERC721_safeTransferFrom(_from, to, token_id, data_len, data)
    return ()
end

@external
func mint{pedersen_ptr : HashBuiltin*, syscall_ptr : felt*, range_check_ptr}(
        to: felt, token_id: Uint256):
    ERC721_mint(to, token_id)
    return ()
end

@external
func declare_animal{pedersen_ptr : HashBuiltin*, syscall_ptr : felt*, range_check_ptr}(
        sex : felt, legs : felt, wings : felt) -> (token_id : Uint256):
    let (rank) = IEvaluator.assigned_rank_storage(contract_address=EVALUATOR, player_address=PLAYER)
    let token_id = Uint256(rank, 0)

    let (values: felt*) = alloc()
    assert values[0] = sex
    assert values[1] = legs
    assert values[2] = wings
    animal_attributes.write(rank, 3, [values])

    return (token_id=token_id)
end

#
# Interfaces
#

@contract_interface
namespace IEvaluator:
    func assigned_rank_storage(player_address : felt) -> (rank : felt):
    end
    func assigned_legs_number(player_address : felt) -> (legs : felt):
    end
    func assigned_sex_number(player_address : felt) -> (sex : felt):
    end
    func assigned_wings_number(player_address : felt) -> (wings : felt):
    end
end

@contract_interface
namespace IExerciceSolution:
    func is_breeder(account : felt) -> (is_approved : felt):
    end
    func registration_price() -> (price : Uint256):
    end
    func register_me_as_breeder() -> (is_added : felt):
    end
    func declare_animal(sex : felt, legs : felt, wings : felt) -> (token_id : Uint256):
    end
    func get_animal_characteristics(token_id : Uint256) -> (sex : felt, legs : felt, wings : felt):
    end
    func token_of_owner_by_index(account : felt, index : felt) -> (token_id : Uint256):
    end
    func declare_dead_animal(token_id : Uint256):
    end
end