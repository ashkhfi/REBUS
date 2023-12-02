<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\Resources;
use App\Models\rental;

class rentalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $rental = rental::with('users', 'costumes')->get();
        $data = $rental->map(function ($rentals) {
            return [
                'id' => $rentals->id,
                'user_id' => $rentals->users,
                'costume_id' => $rentals->costumes,
                'start_date' => $rentals->start_date,
                'end_date' => $rentals->end_date,
                'status' => $rentals->status,
            ];
        });
        return response()->json($data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        //
        $rental = rental::create([
            'user_id' => $request->user_id,
            'costume_id' => $request->costume_id,
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'status' => $request->status,
        ]);
        return new Resources(true, 'Data mahasiswa berhasil ditambahkan!', $rental);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        // find mahasiswa by nim
        $rentals = rental::find($id);

        // check if mahasiswa exists
        if (!$rentals) {
            return new Resources(false, 'Data mahasiswa tidak ditemukan', null);
        }

        // return single mahasiswa as a resource
        return new Resources(true, 'Detail data mahasiswa!', $rentals);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        // find mahasiswa by nim
        $rentals = rental::find($id);
        if (!$rentals) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        } else {
            // update mahasiswa
            $rentals->update(
                [
                    'user_id' => $request->user_id,
                    'costume_id' => $request->costume_id,
                    'start_date' => $request->start_date,
                    'end_date' => $request->end_date,
                    'status' => $request->status,
                ]
            );
        }
        return new Resources(true, 'Data mahasiswa berhasil ditambahkan!', $rentals);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //

        $rentals = rental::find($id);


        if (!$rentals) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }
        //delete post
        $rentals->delete();

        //return response
        return new Resources(true, 'Data berhasil dihapus!', null);
    }
}
